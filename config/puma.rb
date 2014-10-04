threads 0,1
preload_app!
workers 1
environment 'production'
port 3420
tag 'gitrocious'
ENV["SECRET_KEY_BASE"] = "faa000ded405d750d09189a4c6128df8349015d031015d22b402adc6ac5337ae5ae2fc37957a29e7cab1a9f289cb079184c1e75a56218b2b606f7bd24b0c83a3"
