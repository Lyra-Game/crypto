local crypto = require "crypto"

local clientkey = crypto.randomkey()
local data = crypto.base64encode(crypto.dhexchange(clientkey))

print("clientkey = ", clientkey)
print('client data = ', data)

local serverkey = crypto.randomkey()
local data2 = crypto.base64encode(crypto.dhexchange(serverkey))
print("serverkey = ", serverkey)
print('server data = ', data)

local secret = crypto.dhsecret(crypto.base64decode(data), clientkey)
print("secret = ", secret)

local rc4_key = crypto.hmac64_md5(secret, "\0\0\0\0\0\0\0\0")
              ..crypto.hmac64_md5(secret, "\1\0\0\0\0\0\0\0")
              ..crypto.hmac64_md5(secret, "\2\0\0\0\0\0\0\0")
              ..crypto.hmac64_md5(secret, "\3\0\0\0\0\0\0\0")

print("rc4_key = ", rc4_key)
