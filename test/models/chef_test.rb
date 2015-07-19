require 'test_helper'

class ChefTest < ActiveSupport::TestCase

	def setup

		@chef = Chef.new(chefname: "john", email: "john@example.com")
	end

	test "chef should be valid" do
		assert @chef.valid?
		
	end


	test "chefname must be present" do
	
		@chef.chefname = " "
		assert_not @chef.valid?

	end

	test "chefname should not be too short " do
		@chef.chefname = "aa"
		assert_not @chef.valid?
		
	end

	test "chefname should not be too long" do
		@chef.chefname = "a"*41
		assert_not @chef.valid?
	end

	test "email must be present" do
		@chef.email =" "
		assert_not @chef.valid?	
	end

	test "email length must be within bounds" do
		@chef.email = "a"*101 +"@example.com"
		assert_not @chef.valid?
	end

	test "email must be unique" do
		dup_chef = @chef.dup
		dup_chef.email = @chef.email.upcase
		@chef.save
		assert_not dup_chef.valid? 	
	end

	test "email validation should accept valid addressess" do
		valid_address = %w[user@exam.com abc@xyz.pu.co RAC-FF-XY@shkj.jks.com first.last@monk.com mnop+sjjs@koko.org ]

		valid_address.each do |va|
			@chef.email = va
			assert @chef.valid?, "#{va.inspect} should be valid"
		end

	end

	test "email validation should reject invalid addressess" do
		invalid_address = %w[user@exam,com use@exm abc-xyz@ abc@X_YX. ghg@ee_sghs.com]
		invalid_address.each do |ia|
			@chef.email = ia
			assert_not @chef.valid?, "#{ia.inspect} should be invalid"
		end
	end

end
