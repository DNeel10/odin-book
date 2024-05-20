# Replace the 'config_from_url' string value below with your
# product environment's credentials, available from your Cloudinary console.
# =====================================================

require 'cloudinary'

Cloudinary.config_from_url("CLOUDINARY_URL=cloudinary://199836166996421:x0gmr-m1fDN3Xyhv6eS-qLPatpQ@daxtiv6zu")
Cloudinary.config do |config|
  config.secure = true
end