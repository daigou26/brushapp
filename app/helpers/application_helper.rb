module ApplicationHelper
  def default_meta_tags
    {
      site: 'BrushApp',
      reverse: true,
      charset: 'utf-8',
      title: 'プロダクトをSNSに簡単にシェアでき、もらったフィードバックを管理できるサービス',
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
        title: 'BrushApp',
        description: 'プロダクトをSNSに簡単にシェアでき、もらったフィードバックを管理できるサービス',
        url: request.original_url,
        image: {
          url: image_url('brushapp.png'),
          width: 1200,
          height: 630,
        },
        locale: 'ja_JP',
      },
      twitter: {
        card: 'summary_large_image',
        site: '@brushapp_me',
        title: 'BrushApp',
        description: 'プロダクトをSNSに簡単にシェアでき、もらったフィードバック管理できるサービス',
        image: image_url('brushapp.png'),
      }
    }
  end
end
