class Phoenix
	attr_reader :name,
							:color,
							:mood,
							:emotional_awareness
	attr_accessor :pharaoh

	def initialize(name, color = "golden", mood = "stoic")
		@name = name
		@color = color
		@mood = mood
		@emotional_awareness = {}
		@releases_tear = false
		@pharaoh = nil
	end

	def feels_emotion(emotion)
		if @emotional_awareness.has_key?(emotion)
			@emotional_awareness[emotion]+= 1
			change(emotion)
			releases_tear?
		else
			@emotional_awareness[emotion] = 1
			change(emotion)
			releases_tear?
		end
	end

	def change(emotion)
		if @emotional_awareness[emotion] == 1
			@color = "amber"
			@mood = "heated"
		elsif @emotional_awareness[emotion] == 2
			@color = "scarlet"
			@mood = "fiery"
		elsif @emotional_awareness[emotion] == 3
			@color = "crimson"
			@mood = "ablaze"
			@releases_tear = true	
			@pharaoh.healthy = true if @pharaoh != nil		
		elsif @emotional_awareness[emotion] == 4
			@color = "deep violet"
			@mood = "incandescent"
			@releases_tear = false
		else
			@emotional_awareness = {}
			@color = "golden"
			@mood = "stoic"
		end
	end

	def releases_tear?
		@releases_tear
	end

	def follows_pharaoh(pharaoh)
		@pharaoh = pharaoh
	end
end 

class Pharaoh
	attr_reader :name,
							:reputation,
							:dynastic_period,
							:phoenix
							
	attr_accessor :age,
								:healthy								
	
	def initialize(name, reputation, dynastic_period, phoenix)
		@name = name
		@reputation = reputation
		@dynastic_period = dynastic_period
		@phoenix = phoenix
		@age = 0
		@healthy = true
		@dead = false
	end

	def healthy?
		@healthy
	end

	def ages
		@age += 1
		if @age >= 18
			@healthy = false
		end
	end

	def takes_action(action)
		@phoenix.feels_emotion(action)
	end

	def alive?
		!@dead
	end			

	def dies
		@dead = true
		5.times {@phoenix.feels_emotion(:sorrow)}
		@phoenix.pharaoh = nil
	end
end
	