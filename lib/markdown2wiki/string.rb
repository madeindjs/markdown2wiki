
class String

	INDENT_CHAR = "\t"

	# Wikiに変換する
	def markdown_to_wiki
		# 斜体
		self.convert_italic!
		# 太字
		self.convert_strong!
		# 打ち消し線
		self.convert_strikethrough!
		# 見出し
		self.convert_heading!
		# 順序なしリスト
		self.convert_unordered_list! INDENT_CHAR
		# 順序つきリスト
		self.convert_ordered_list! INDENT_CHAR
		# リンク
		self.convert_link!

		return self
	end

	private

	def convert_strong!
		self.gsub(/\*\*((?!\s)[^\*]+?)\*\*(?=[^\*|$]{1})/, '*\1*')
		self.gsub(/__((?!\s)[^_]+?)__(?=[^_|$]{1})/, '*\1*')
		return self
	end

	def convert_italic!
		self.gsub!(/\*((?!\s)[^\*]+?)\*(?=[^\*|$]{1})/, '_\1_')
		return self
	end

	def convert_strikethrough!
		self.gsub!(/~(.+?)~/, '-\1-')
		return self
	end

	def convert_heading!
		/(#+)/ =~ self

		if $1.nil?
			return self
		end

		tag = "h#{$1.length}."
		self.gsub!(/(#+)/, tag)
		return self
	end

	def convert_unordered_list!(space = nil)
		space ||= '\t'

		pattern = /^(#{space}*\*)/
		pattern =~ self

		if $1.nil?
			return self
		end

		symbol = '*'
		$1.scan(/\t/).size.to_i.times do
			symbol += '*'
		end

		self.gsub!(pattern, symbol)
		return self
	end

	def convert_ordered_list!(space = nil)
		space ||= '\t'

		pattern = /^(#{space}*[0-9]+?\.)/
		pattern =~ self

		if $1.nil?
			return self
		end

		symbol = '#'
		$1.scan(/\t/).size.to_i.times do
			symbol += '#'
		end

		self.gsub!(pattern, symbol)
		return self
	end

	def convert_link!
		/\[(.+?)\]\((.+?)( "(.+)")?\)/ =~ self

		if $1.nil?
			return self
		end
	
		title = ''

		if !$4.nil?
			title = '(' + $4 + ')'
		end
	
		link = '"' + $1 + title + '":' + $2
	
		self.gsub!(/\[(.+?)\]\((.+?)( "(.+)")?\)/, link)
		return self
	end
end
