local crypt = require "crypt"

local clientkey = crypt.randomkey()
local data = crypt.base64encode(crypt.dhexchange(clientkey))

print("clientkey = ", clientkey)
print('client data = ', data)

local serverkey = crypt.randomkey()
local data2 = crypt.base64encode(crypt.dhexchange(serverkey))
print("serverkey = ", serverkey)
print('server data = ', data)

local secret = crypt.dhsecret(crypt.base64decode(data), clientkey)
print("secret = ", secret)

local rc4_key = crypt.hmac64_md5(secret, "\0\0\0\0\0\0\0\0")
              ..crypt.hmac64_md5(secret, "\1\0\0\0\0\0\0\0")
              ..crypt.hmac64_md5(secret, "\2\0\0\0\0\0\0\0")
              ..crypt.hmac64_md5(secret, "\3\0\0\0\0\0\0\0")

print("rc4_key = ", rc4_key)
