module SVG
	def method_missing(name, *args, &block)
    	if name.to_s == "SVG"
    		@str = "<#{args[0]}"
      		block.call
      		return @str += "/>\n"
    	end

    	if ["x1", "y1", "x2", "y2", "cx", "cy", "x", "y", "r", "width", "height", "fill", "stroke"].include?(name.to_s)
     		@str += generate_attr(name.to_s.to_s, args[0])
   		end
  	end

  	def generate_attr (name, value)
   		" " + name + "='" + value.to_s + "'"
	end
end

class Line 
	include SVG
	def initialize (x1,y1,x2,y2,stroke = 'black')
		@x1, @y1, @x2, @y2, @stroke = x1, y1, x2, y2, stroke
		
	end

	def draw
		SVG:line do
			x1 @x1
			y1 @y1
			x2 @x2
			y2 @y2
			stroke @stroke
		end
	end
end

class Rect
	include SVG
	def initialize(x,y,width,height)
		@x, @y, @width, @height = x, y, width, height
	end
	
	def draw
		SVG:rect do
			x @x
			y @y
			width @width
			height @height
		end
	end
end

class Circle
	include SVG
	def initialize(cx,cy,r, fill = 'transparent')
		@cx, @cy, @r, @fill= cx,cy,r,fill
		@stroke = 'black'
		#@stroke_width = 2
	end
	
	def draw
		SVG:circle do
			cx @cx
			cy @cy
			r @r 
			fill @fill
			stroke @stroke
			#stroke-width @stroke_width
		end
	end
end

class Arrow
	def initialize(x1,y1,x2,y2)
		@x1, @y1, @x2, @y2 = x1, y1, x2, y2
		@stroke = 'green'
		@cx = x2
		@cy = y2
		@r = 3
		@fill = 'yellow'
	end

	def draw
		line = Line.new(@x1, @y1, @x2, @y2, @stroke)
		circle = Circle.new(@cx, @cy, @r, @fill)
		line.draw + circle.draw
	end
end

def Draw_array_to_svg(array, file_name)
	head_line = "<?xml version=\"1.0\" encoding=\"UTF-8\" standalone=\"no\"?> \n<svg xmlns=\"http://www.w3.org/2000/svg\" version=\"1.1\" width=\"300\" height=\"300\"> \n"
	end_line = "</svg>"
	
	File.open(file_name, 'a') do |f|
		f.write(head_line)
	end
	array.each do |el|
		File.open(file_name, 'a') do |f|
			f.write(el.draw)
		end
	end
	File.open(file_name, 'a') do |f|
		f.write(end_line)
	end
end

elements = [
  Line.new(50, 160, 50, 220),
  Rect.new(42, 120, 16, 40),
  Line.new(75, 235, 100, 235),
  Line.new(50, 275, 200, 275),
  Circle.new(50, 180, 3, 'black'),
  Line.new(50, 100, 50, 120),
  Arrow.new(200, 250, 175, 240),
  Line.new(75, 220, 75, 250, 3),
  Circle.new(100, 100, 3, 'black'),
  Line.new(100, 160, 100, 180),
  Line.new(200, 220, 175, 230),
  Line.new(110, 290, 140, 290),
  Line.new(178, 165, 178, 195),
  Line.new(200, 160, 200, 220),
  Line.new(100, 180, 150, 235),
  Line.new(150, 180, 100, 235),
  Line.new(200, 250, 200, 275),
  Line.new(200, 100, 200, 120),
  Circle.new(125, 275, 3, 'black'),
  Line.new(78, 165, 78, 195),
  Arrow.new(50, 100, 250, 100),
  Circle.new(100, 180, 3, 'black'),
  Line.new(100, 100, 100, 120),
  Rect.new(92, 120, 16, 40),
  Circle.new(200, 100, 3, 'black'),
  Circle.new(200, 180, 3, 'black'),
  Line.new(50, 180, 72, 180),
  Line.new(72, 165, 72, 195),
  Circle.new(70, 235, 25),
  Line.new(150, 100, 150, 120),
  Line.new(125, 275, 125, 290),
  Line.new(78, 180, 100, 180),
  Line.new(150, 180, 172, 180),
  Circle.new(180, 235, 25),
  Line.new(172, 165, 172, 195),
  Circle.new(150, 180, 3, 'black'),
  Arrow.new(178, 180, 250, 180),
  Line.new(150, 160, 150, 180),
  Line.new(175, 235, 150, 235),
  Rect.new(142, 120, 16, 40),
  Line.new(50, 250, 50, 275),
  Circle.new(150, 100, 3, 'black'),
  Rect.new(192, 120, 16, 40),
  Line.new(50, 220, 75, 230),
  Line.new(175, 220, 175, 250, 3),
  Arrow.new(50, 250, 75, 240)
]

Draw_array_to_svg(elements, 'svg_schema.svg')