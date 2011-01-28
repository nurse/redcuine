module Redcuine
  module OptParser
    def self.issue_parse!(argv)
      @issue_optionparser.parse!(argv)
    end

    private
    def self.default_opts(opt)
      opt.on('-p', '--post', 'POST by REST API') do
        CONFIG["rest_type"] = :post
      end

      opt.on('-g', '--get', 'GET by REST API') do |val|
        CONFIG["rest_type"] = :get
      end

      opt.on('-u', '--put', 'PUT by REST API') do |val|
        CONFIG["rest_type"] = :put
      end

      opt.on('-d', '--delete', 'DELETE by REST API') do |val|
        CONFIG["rest_type"] = :delete
      end
      opt.on('--dry-run', 'Print plane text for REST. For debug') do |val|
        CONFIG["dry_run"] = val
      end
    end

    @issue_optionparser = OptionParser.new do |opt|
      opt.program_name = 'redissue'

      %w(id subject describe tracker-id status-id category-id assigned-to
         priority fixed-version start-date due-date estimate-date
         done-ratio site).each do |k|
        src = <<-SRC
        opt.on('--#{k} val', 'Set #{k.gsub("-", " ")}') do |val|
          CONFIG["#{k.gsub("-", "_")}"] = val
        end
        SRC
        eval(src)
      end
      default_opts(opt)
    end
  end
end