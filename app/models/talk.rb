class Talk < ActiveRecord::Base

	has_one :slot

	validates :title,
	:length => {
		:minimum => 1,
		:maximum => 64,
		:allow_blank => true,
		:message => "needs to be at least 1 character long and fewer than 64 (it\'s currently %{count})"
	}

	validates :speaker,
	:length => {
		:minimum => 1,
		:maximum => 64,
		:allow_blank => true,
		:message => "needs to be at least 1 character long and fewer than 64 (it\'s currently %{count})"
	}

	validates :description,
	:length => {
		:minimum => 1,
		:maximum => 128,
		:allow_blank => true,
		:message => "needs to be at least 1 character long and fewer than 128 (it\'s currently %{count})"
	}

	validates_presence_of :title, :if => proc{|obj| obj.description.blank? && obj.speaker.blank? }
	validates_presence_of :description, :if => proc{|obj| obj.title.blank? && obj.speaker.blank? }
	validates_presence_of :speaker, :if => proc{|obj| obj.title.blank? && obj.description.blank? }

	after_save :clear_cache

	def self.unscheduled
		talks = Talk.select {|talk| talk.is_unscheduled}
		talks.sort_by(&:updated_at).reverse
	end

	def self.by_updated
		Talk.limit(50).order("updated_at DESC")
	end

	def is_unscheduled
		if (slot == nil)
			return true
		end
		return false
	end

	def etherpad_link
		"http://etherpad.wikimedia.org/bcl" + id.to_s
	end

	private

	def clear_cache
		unless self.slot.nil?
			REDIS.keys("views/slot_#{self.slot.id}*").each do |key|
				REDIS.del(key)
			end
		end
	end

end
