
class String

	INDENT_CHAR = "\t"

	# Wikiに変換する
	def markdown_to_wiki
		wiki = self

		# convert italic!
		wiki.gsub!(/[^\*]\*(\w+)\*(\s|\.)/, ' _\1_\2')

		# convert strong!
		wiki.gsub!(/(\s|\.)\*\*(.+)\*\*(\s|\.)/, '\1*\2*\3')

		# convert link!
		wiki.gsub!(/\[(.*)\]\((.*)\)/, '"\1":\2')

		# convert block code
		wiki.gsub!(/(~|`){3}([a-z]+)/, '<pre><code class="\2">')
		wiki.gsub!(/(~|`){3}/, '</code></pre>')

		# convert unsorted list
		wiki.gsub!(/(-|\*) (.*\n)/, '* \2')

		# convert sorted list
		wiki.gsub!(/[1-9]+\. (.*\n)/, '# \1')

		# wiki.gsub!(/|(~~~\|```)/, '</pre></code>')
		# convert inline code
		wiki.gsub!(/\`((?!\s)[^\`]+?)\`/, '@\1@')

		# convert strikethrough!
		wiki.gsub!(/~(.+?)~/, '-\1-')

		# convert heading!
		/(#+).*\n\n/ =~ wiki
		unless $1.nil?
			tag = "h#{$1.length}."
			wiki.gsub!(/(#+)/, tag)
		end

		return wiki
	end

end
