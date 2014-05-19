class YoutubeVideo

  attr_reader :code

  def self.code_from_iframe iframe
    begin
      code_from_url iframe.match( /src=['|"](.*?)['|"]/i )[1]
    rescue
      nil
    end
  end

  def self.code_from_url url
    if url[/youtu\.be\/([^\?]*)/]
      youtube_id = $1
    else
      # Regex from # http://stackoverflow.com/questions/3452546/javascript-regex-how-to-get-youtube-video-id-from-url/4811367#4811367
      url[/^.*((v\/)|(embed\/)|(watch\?))\??v?=?([^\&\?]*).*/]
      youtube_id = $5
    end

    youtube_id
  end

  def self.new_from_iframe iframe, options = {}
    instance = allocate
    instance.iframe_initialize iframe, options
    instance
  end

  def initialize code, options = {}
    @code    = code
    @options = options
  end

  def image version = '0'
    "http://img.youtube.com/vi/#{code}/#{version}.jpg"
  end

  def iframe iframe_options = {}
    width  = iframe_options[:width]  || 560
    height = iframe_options[:height] || 315

    params = {}
    params[:autoplay] = 1 if iframe_options[:autoplay]

    if code
      "<iframe width=\"#{width}\" height=\"#{height}\" src=\"//www.youtube.com/embed/#{code}?#{params.to_param}\" frameborder=\"0\" allowfullscreen></iframe>"
    else
      nil
    end
  end

  def iframe_initialize iframe, options = {}
    @iframe  = iframe
    @code    = self.class.code_from_iframe iframe
    @options = options
  end

end