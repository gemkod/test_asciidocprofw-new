if Asciidoctor::Converter.for 'pdf'
  class PDFConverterSidebarRole < (Asciidoctor::Converter.for 'pdf')
    register_for 'pdf'

    def convert_sidebar(node)
      if node.role?
        key_prefix = "role_<sidebar>_#{node.roles[0]}_"
        unless (role_entries = theme.each_pair.select { |name, val| name.to_s.start_with? key_prefix }).empty?
          save_theme do
            role_entries.each do |name, val|
              theme["sidebar_#{name.to_s.delete_prefix(key_prefix)}"] = val
            end
            super
          end
          return
        end
      end
      super
    end
  end
end
