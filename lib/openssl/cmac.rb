require 'openssl'

module OpenSSL
  # TODO
  class CMACError < StandardError
  end

  # Hallo Welt
  # http://tools.ietf.org/html/rfc4493
  # http://tools.ietf.org/html/rfc4494
  # http://tools.ietf.org/html/rfc4615
  class CMAC
    # Searches for supported algorithms within OpenSSL
    #
    # @return [Stringlist] of supported algorithms
    def self.ciphers
      l = OpenSSL::Cipher.ciphers.keep_if { |c| c.end_with?('-128-CBC') }
      l.length.times { |i| l[i] = l[i][0..-9] }
      l
    end

    def self.digest(cipher, key, data)
      CMAC.new(cipher, key).digest(data)
    end

    public

    def initialize(cipher, key = '')
      unless CMAC.ciphers.include?(cipher)
        fail CMACError, "unsupported cipher algorithm (#{cipher})"
      end

      @keys = []
      @buffer = ''.force_encoding('ASCII-8BIT')
      @cipher = OpenSSL::Cipher.new("#{cipher}-128-CBC")

      reset
      self.key = key unless key == ''
    end

    def key=(key)
      key = CMAC.digest('AES', "\x00" * 16, key) unless key.b.length == 16

      @keys[0] = key.dup
      @cipher.key = @keys[0]

      cipher = OpenSSL::Cipher.new(@cipher.name)
      cipher.encrypt
      cipher.key = @keys[0]
      k = cipher.update("\x00" * 16).bytes
      1.upto(2) do |i|
        k = k.pack('C*').unpack('B*')[0]
        msb = k.slice!(0)
        k = [k, '0'].pack('B*').bytes
        k[15] ^= 0x87 if msb == '1'
        @keys[i] = k.dup
      end
    end

    def <<(data)
      update(data)
    end

    def block_length
      16
    end

    def digest_length
      16
    end

    def name
      "CMAC with #{@cipher.name[0..-9]}"
    end

    def reset
      @keys.clear
      @buffer.clear
      @cipher.reset
      @cipher.encrypt
      self
    end

    def update(data)
      fail CMACError, 'no key is set' if @keys[0].nil?

      @buffer += data
      @cipher.update(@buffer.slice!(0...16)) while @buffer.length > 16
      self
    end

    def digest(data = '')
      fail CMACError, 'no key is set' if @keys[0].nil?

      update(data) unless data.empty?

      block = @buffer.bytes
      @buffer.clear
      k = @keys[block.length == 16 ? 1 : 2].dup
      i = block.length.times { |t| k[t] ^= block[t] }
      k[i] ^= 0x80 if i < 16
      mac = @cipher.update(k.pack('C*'))
      @cipher.reset
      @cipher.encrypt
      @cipher.key = @keys[0]
      mac
    end
  end
end
