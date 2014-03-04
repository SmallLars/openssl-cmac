# Test Vectors
# 
# The following test vectors are the same as those of [NIST-CMAC].
# 
# --------------------------------------------------
# Subkey Generation
# K              2b7e1516 28aed2a6 abf71588 09cf4f3c
# AES-128(key,0) 7df76b0c 1ab899b3 3e42f047 b91b546f
# K1             fbeed618 35713366 7c85e08f 7236a8de
# K2             f7ddac30 6ae266cc f90bc11e e46d513b
# --------------------------------------------------
# 
# --------------------------------------------------
# Example 1: len = 0
# M              <empty string>
# AES-CMAC       bb1d6929 e9593728 7fa37d12 9b756746
# --------------------------------------------------
# 
# Example 2: len = 16
# M              6bc1bee2 2e409f96 e93d7e11 7393172a
# AES-CMAC       070a16b4 6b4d4144 f79bdd9d d04a287c
# --------------------------------------------------
# 
# Example 3: len = 40
# M              6bc1bee2 2e409f96 e93d7e11 7393172a
# ae2d8a57 1e03ac9c 9eb76fac 45af8e51
# 30c81c46 a35ce411
# AES-CMAC       dfa66747 de9ae630 30ca3261 1497c827
# --------------------------------------------------
# 
# Example 4: len = 64
# M              6bc1bee2 2e409f96 e93d7e11 7393172a
# ae2d8a57 1e03ac9c 9eb76fac 45af8e51
# 30c81c46 a35ce411 e5fbc119 1a0a52ef
# f69f2445 df4f9b17 ad2b417b e66c3710
# AES-CMAC       51f0bebf 7e3b9d92 fc497417 79363cfe
# --------------------------------------------------

require 'openssl_cmac'

describe OpenSSL::CMAC do
  cmac = OpenSSL::CMAC.new(['2b7e151628aed2a6abf7158809cf4f3c'].pack('H*'))

  it "Generates valid CMAC for zero-length message" do
    cmac.generate("").unpack('H*').pop.should eq('bb1d6929e95937287fa37d129b756746')
  end

  it "Generates valid CMAC for 16-byte length message" do
    cmac.generate(['6bc1bee22e409f96e93d7e117393172a'].pack('H*')).unpack('H*').pop.should eq('070a16b46b4d4144f79bdd9dd04a287c')
  end

  it "Generates valid CMAC for 40-byte length message" do
    cmac.generate(['6bc1bee22e409f96e93d7e117393172aae2d8a571e03ac9c9eb76fac45af8e5130c81c46a35ce411'].pack('H*')).unpack('H*').pop.should eq('dfa66747de9ae63030ca32611497c827')
  end

  it "Generates valid CMAC for 64-byte length message" do
    cmac.generate(['6bc1bee22e409f96e93d7e117393172aae2d8a571e03ac9c9eb76fac45af8e5130c81c46a35ce411e5fbc1191a0a52eff69f2445df4f9b17ad2b417be66c3710'].pack('H*')).unpack('H*').pop.should eq('51f0bebf7e3b9d92fc49741779363cfe')
  end
end
