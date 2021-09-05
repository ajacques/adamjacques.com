Sentry.init do |config|
  config.breadcrumbs_logger = [:active_support_logger, :http_logger]

  config.traces_sampler = lambda do |context|
    unless context[:parent_sampled].nil?
      next context[:parent_sampled]
    end

    transaction_context = context[:transaction_context]
    op = transaction_context[:op]
    transaction_name = transaction_context[:name]

    case op
    when /request/
      case transaction_name
      when 'health#ping'
        0
      else
        0.5
      end
    else
        0.5
    end
  end
end
