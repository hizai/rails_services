################################################################################
# TWITTER CARD GENERATOR 																											 #
# ============================================================================ #
# 																																						 #
# Docs 																																				 #
# ---------------------------------------------------------------------------- #
#	 																																						 #
#	Twitter Cards official documentation: https://dev.twitter.com/docs/cards		 #
#																																						   #
# Usage   																																		 #
# ---------------------------------------------------------------------------- #
# 																																						 # 
# While initializing a generator you can pass it the default specs for the 		 #
# twitter cards it is going to generate.																			 #
#  																																						 #
# 	generator = TwitterCardGenerator.new :card 				=> :summay_large_image,  #
#																				 :title 			=> "My card", 					 #
#																				 :description => "Lorem Ipsum ..."		 #
# 																																						 #
# Use the #generate method to generate the html for the card. You can also     #
# pass the desired attributes for your card to the method; an attribute 			 #
# inputted this way will overwritte its default value in the case it exists.   #
# 																																						 #
#   twitter_card = generator.generate :card => :summary 											 #
# 																																						 #
# In this case a summary twitter card with title 'My card' and description     #
# 'Lorem Ipsum ...' is going to be generated.                                  #
# 																																						 #
################################################################################   

class TwitterCardGenerator

	REQUIRED_ATTRIBUTES = {
		summary: 			 			 [ :title, :description ],
		summary_large_image: [ :title, :description ],
		photo: 				 			 [ :image ],
		gallery: 			 			 [ :image0, :image1, :image2, :image3 ],
		app: 				   			 [
			:"app:id:iphone", :"app:id:ipad", :"app:id:googleplay"
		],
		product: 			 			 [
			:title, :description, :image, :data1, :label1, :data2, :label2
		],
		player: 			 			 [
		  :title, :description, :player, :"player:width", :"player:height",
		  :image # :"player:stream:content_type" also required if :"player:stream" 
		]
	}

	def initialize defaults = {}, options = {}
		@defaults = defaults
		@options  = options

		@default_card_type = defaults[ :card ] || :summary 
	end

	def generate attributes = {}
		attributes = @defaults.merge( attributes ).
													 reverse_merge :card => card_type_for( attributes )

		check_presence_of_required attributes
		twitter_card_with 		     attributes
	end

	private

	def twitter_card_with attributes
		attributes.map do |attr|
			name    = "twitter:" + Rack::Utils.escape_html( attr[0].to_s )
			content = Rack::Utils.escape_html attr[1].to_s

			"<meta name=\"" + name + "\" content=\"" + content + "\">"
		end.join("\n\s\s\s\s").html_safe
	end

	def check_presence_of_required attributes
		required_attributes = REQUIRED_ATTRIBUTES[ card_type_for attributes ]

		missing_attributes = required_attributes - attributes.keys 
		unless missing_attributes.empty? 
			raise MissingRequiredAttributesError, "#{missing_attributes}"
		end
	end

	def card_type_for attributes
		attributes[ :card ] || @default_card_type
	end
	
end

class MissingRequiredAttributesError < StandardError
end