module Titler
  module TitlerHelper
    def page_title(page_title)
      content_for(:page_title) {page_title}
    end

    def titler(custom_vars = {})
      context = controller.view_assigns.merge(custom_vars).symbolize_keys
      Title.new(
        controller: controller,
        i18n: I18n,
        title_as_set: content_for(:page_title) || @page_title,
        context: context
      ).to_s
    end

    class Title
      def initialize(controller:, i18n:, title_as_set:, context:)
        @controller = controller
        @i18n = i18n
        @title_as_set = title_as_set
        @context = context
        @configuration = Configuration.new
      end

      def to_s
        th = title_hash = Hash.new
        th[:env_prefix] = env_prefix
        th[:admin_namespace] = admin_namespace
        th[:title_body] = title_body
        th[:app_name] = app_name
        th[:app_tagline] = app_tagline
        build_title_str(th)
      end

      private

      def env_prefix
        if @configuration.use_env_prefix
          Rails.env.production? ? '' : "(#{Rails.env[0,1].upcase}) "
        else
          ''
        end
      end

      def admin_namespace
        admin_namespace? ? admin_default_name + delimiter : ''
      end

      def admin_namespace?
        @controller.class.ancestors.include?(@configuration.admin_controller)
      end

      def admin_default_name
        @configuration.admin_name
      end

      def delimiter
        @i18n.exists?('titler.delimiter') ? @i18n.t('titler.delimiter') : @configuration.delimiter
      end

      def app_name
        if @i18n.exists?('titler.app_name') && @i18n.t('titler.app_name').present?
          @i18n.t('titler.app_name')
        else
          Rails.application.class.to_s.split("::").first
        end
      end

      def app_tagline
        tagline = @i18n.exists?('titler.app_tagline') ? @i18n.t('titler.app_tagline') : ''
      end

      def title_body
        if @title_as_set.present?
          @title_as_set
        else
          @controller.controller_name.titleize + ' ' + @controller.action_name.titleize rescue ''
        end
      end

      def build_title_str(th)
        case @configuration.app_name_position
        when 'append'
          th[:env_prefix] + th[:admin_namespace] + th[:title_body] + app_tagline_str(th) + app_name_str(th)
        when 'prepend'
          th[:env_prefix] + app_name_str(th) + app_tagline_str(th) + th[:admin_namespace] + th[:title_body]
        else
          th[:env_prefix] + th[:admin_namespace] + th[:title_body] + app_tagline_str(th)
        end
      end

      def app_name_str(th)
        if title_body.blank?
          th[:app_name]
        else
          case @configuration.app_name_position
          when 'append'
            delimiter + th[:app_name]
          when 'prepend'
            th[:app_name] + delimiter
          else
            ''
          end
        end
      end

      def app_tagline_str(th)
        tagline = th[:app_tagline]
        if tagline.blank? || !@configuration.use_app_tagline
          ''
        else
          case @configuration.app_name_position
          when 'append'
            delimiter + tagline
          when 'prepend'
            tagline + delimiter
          end
        end
      end
    end
  end
end
