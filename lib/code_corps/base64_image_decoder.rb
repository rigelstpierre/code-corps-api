class Base64ImageDecoder
  DATA_URI_REGEX = /^data:image\/[^;]+;base64,/

  attr_accessor :base64_string

  def initialize(base64_string)
    @base64_string = base64_string
  end

  def decode
    base64_string.gsub!(DATA_URI_REGEX, "")
    data = StringIO.new(Base64.decode64(base64_string))
    data.class.class_eval { attr_accessor :original_filename, :content_type }
    data.original_filename = SecureRandom.hex + ".png"
    data.content_type = "image/png"
    data
  end
end