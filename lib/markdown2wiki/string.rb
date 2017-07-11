
class String

	INDENT_CHAR = "\t"

	# Wikiに変換する
	def markdown_to_wiki
		# add space around string to match markdown tag
		wiki = " #{self} "

		not_splat = '[^\*]'

		# convert italic!
		wiki.gsub!(/(#{not_splat})\*(#{not_splat}+)\*(#{not_splat})/, '\1_\2_\3')

		# convert strong!
		wiki.gsub!(/(#{not_splat})\*\*(#{not_splat}+)\*\*(#{not_splat})/, '\1*\2*\3')

		# convert link!
		regex_url = /(https?:\/\/[\S]+)/
		wiki.gsub!(/\[(.*)\]\(#{regex_url}\)/, '"\1":\2')

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

		# delete spaces added first and return string 
		return wiki[1..-2]
	end

end
