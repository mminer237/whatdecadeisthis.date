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
			self.data['full_title'] = "What Decade is #{year}?"
			decade = (year / 10.0).ceil()
			self.data['ordinalDecade'] = decade.to_s + Jekyll.ordinal(decade)
			self.data['cardinalDecade'] = (year / 10).to_s + '0s'
			if self.data['cardinalDecade'] == "00s"
				self.data['cardinalDecade'] = "0s"
			end
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

	class OrdinalDecadePage < Page
		def initialize(site, base, dir, name, decade)
			@site = site
			@base = base
			@dir = dir
			@name = name
			self.process(@name)
			self.data ||= {}
			self.data['layout'] = 'ordinal-decade'
			self.data['ordinal'] = Jekyll.ordinal(decade)
			self.data['title'] = "#{decade}#{self.data['ordinal']} Decade"
			self.data['decade'] = decade
		end
	end

	class CardinalDecadePage < Page
		def initialize(site, base, dir, name)
			@site = site
			@base = base
			@dir = dir
			@name = name
			self.process(@name)
			self.data ||= {}
			self.data['layout'] = 'cardinal-decade'
			decade_name = name.rpartition('.').first
			self.data['title'] = decade_name
			self.data['first_year'] = Integer(decade_name.rpartition('s').first)
		end
	end

	class DecadePageGenerator < Generator
		def generate(site)
			decades = (1..(Integer((site.config['lastYear']) / 10.0).ceil() + 1))
			decades.each do |decade|
				ordinal_name = "#{decade}#{Jekyll.ordinal(decade)}-decade.md"
				puts ordinal_name
				page = Jekyll::OrdinalDecadePage.new(site, site.source, @dir, ordinal_name, decade)
				site.pages << page

				if decade == 1
					cardinal_name = "0s.md"
				else
					cardinal_name = "#{decade - 1}0s.md"
				end
				puts cardinal_name
				page = Jekyll::CardinalDecadePage.new(site, site.source, @dir, cardinal_name)
				site.pages << page
			end
		end
	end
end