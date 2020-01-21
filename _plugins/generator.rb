module Jekyll
	def self.ordinal(n)
		n = n.to_i.abs

		if (11..13).include?(n % 100)
			"th"
		else
			case n % 10
				when 1 then "st"
				when 2 then "nd"
				when 3 then "rd"
				else        "th"
			end
		end
	end

	class YearPage < Page
		def initialize(site, base, dir, name)
			@site = site
			@base = base
			@dir = dir
			@name = name
			self.process(@name)
			self.data ||= {}
			self.data['layout'] = 'year'
			if name == "year-404.md"
				year = 404
			else
				year = Integer(name.rpartition('.').first)
			end
			self.data['title'] = year
			decade = (year / 10.0).ceil()
			self.data['ordinalDecade'] = decade.to_s + Jekyll.ordinal(decade)
			self.data['cardinalDecade'] = (year / 10 + 1).to_s + '0s'
		end
	end

	class YearPageGenerator < Generator
		def generate(site)
			years = (1..Integer(site.config['lastYear']))
			years.each do |year|
				if year == 404
					name = "year-404.md"
				else
					name = "#{year}.md"
				end
				puts name
				page = Jekyll::YearPage.new(site, site.source, @dir, name)
				# page.data['title'] = year
				# page.data['layout'] = 'year'
				# page.content = "This is #{year}"
				site.pages << page
			end
		end
	end
end