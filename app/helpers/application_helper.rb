module ApplicationHelper
  def default_meta_tags
    {
      site: 'BrushApp',
      reverse: true,
      charset: 'utf-8',
      title: 'プロダクトをSNSに簡単にシェアでき、フィードバックが管理できるサービス',
      description: 'プロダクトを簡単SNSにシェアすることができます。また、もらったフィードバックを管理することができます。',
      canonical: request.original_url,
      separator: '|',
      icon: [
        { href: image_url('favicon.ico') },
        { href: image_url('icon.png'), rel: 'apple-touch-icon', sizes: '180x180', type: 'image/png' },
      ],
      og: {
        site_name: 'BrushApp',
        type: 'website',
        title: 'プロダクトをSNSに簡単にシェアでき、フィードバック管理ができるサービス | BrushApp',
        description: 'プロダクトを簡単SNSにシェアすることができます。また、もらったフィードバックを管理することができます。',
        url: request.original_url,
        locale: 'ja_JP',
      },
      twitter: {
        card: 'summary_large_image',
        site: '@brushapp_me',
      }
    }
  end
end
