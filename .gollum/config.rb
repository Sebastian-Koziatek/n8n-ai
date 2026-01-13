# Gollum configuration for reverse proxy and custom CSS

Gollum::Hook.register(:startup, :hook_id) do |gollum, config|
  # Allow Gollum to work behind a reverse proxy
  config[:per_page_uploads] = true
end

# Configure for reverse proxy
module Precious
  class App < Sinatra::Base
    configure do
      set :protection, except: [:json_csrf, :frame_options]
    end
    
    # Inject custom CSS into every page
    helpers do
      def custom_css_tag
        '<link rel="stylesheet" type="text/css" href="http://10.123.0.201:8081/custom.css">'
      end
    end
  end
end

# Hook to inject CSS
Gollum::Hook.register(:post_render, :inject_css) do |page, context|
  if context[:output]
    context[:output].sub!(/<\/head>/, "#{custom_css_tag}</head>")
  end
end
