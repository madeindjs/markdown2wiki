
class String

	INDENT_CHAR = "\t"

	# Wikiに変換する
	def markdown_to_wiki
		wiki = self

		# convert italic!
		wiki.gsub!(/\*((?!\s)[^\*]+?)\*(?=[^\*|$]{1})/, '_\1_')
		# convert link!
		wiki.gsub!(/\[(.*)\]\((.*)\)/, '"\1":\2')
		# convert strong!
		wiki.gsub!(/\*\*((?!\s)[^\*]+?)\*\*(?=[^\*|$]{1})/, '*\1*')
		# convert block code
		wiki.gsub!(/(~|`){3}([a-z]+)/, '<pre><code class="\2">')
		wiki.gsub!(/(~|`){3}/, '</code></pre>')
		# wiki.gsub!(/|(~~~\|```)/, '</pre></code>')
		# convert inline code
		wiki.gsub!(/\`((?!\s)[^\`]+?)\`/, '@\1@')

		# convert strikethrough!
		wiki.gsub!(/~(.+?)~/, '-\1-')

		# convert heading!
		/(#+)\n/ =~ wiki
		unless $1.nil?
			tag = "h#{$1.length}."
			wiki.gsub!(/(#+)/, tag)
		end


		return wiki
	end

	# private

	# 	wiki = self


	# 	return self
	# end

	# 	# convert unordered_list!(space = nil)
	# 	space ||= '\t'

	# 	pattern = /^(#{space}*\*)/
	# 	pattern =~ self

	# 	if $1.nil?
	# 		return self
	# 	end

	# 	symbol = '*'
	# 	$1.scan(/\t/).size.to_i.times do
	# 		symbol += '*'
	# 	end

	# 	self.gsub!(pattern, symbol)
	# 	return self
	# end

	# 	# convert ordered_list!(space = nil)
	# 	space ||= '\t'

	# 	pattern = /^(#{space}*[0-9]+?\.)/
	# 	pattern =~ self

	# 	if $1.nil?
	# 		return self
	# 	end

	# 	symbol = '#'
	# 	$1.scan(/\t/).size.to_i.times do
	# 		symbol += '#'
	# 	end

	# 	self.gsub!(pattern, symbol)
	# 	return self
	# end

	# 	# convert link!
	# 	/\[(.+?)\]\((.+?)( "(.+)")?\)/ =~ self

	# 	if $1.nil?
	# 		return self
	# 	end
	
	# 	title = ''

	# 	if !$4.nil?
	# 		title = '(' + $4 + ')'
	# 	end
	
	# 	link = '"' + $1 + title + '":' + $2
	
	# 	self.gsub!(/\[(.+?)\]\((.+?)( "(.+)")?\)/, link)
	# 	return self
	# end
end
