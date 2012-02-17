require 'rspec'
require_relative 'six.rb'

describe "parsing" do
	describe "mentions" do
		before(:each) do	
			@line = 'christie: "Every day, men and women, conversing, beholding and beholden..." /cc @alberta, @bob'
		end

		it "should grab the speaker's name from a line" do
			tweeter(@line).should == "christie"
		end

		it "should grab each mentioned person" do
			tweeties(@line).should == ["alberta","bob"]
		end

		it "should build small array of tweeter-tweetie mentions" do
			mentions(@line).should == [["christie","alberta"],["christie","bob"]]
		end

		it "should not insert duplicate mentions" do
			existing_mentions = [["christie","alberta"],["christie","bob"]]
			add_mentions(@line, existing_mentions).should == existing_mentions
		end

		it "should add new mentions too" do
			existing_mentions = [["christie","alberta"],["bob","dave"]]
			existing_mentions = add_mentions(@line, existing_mentions)
			# puts existing_mentions
			existing_mentions.should == [["christie","alberta"],["bob","dave"],["christie","bob"]]
		end
	end

	describe "first tier relationships" do
		before(:each) do
			@mentions = [['P1', 'P2'], ['P2', 'P1'], ['P1', 'P3']]

		end
		it "adds the proper people relationships" do 
			first_order_relationships = map_first_order_relationships(@mentions)
			first_order_relationships.should == [['P1', 'P2'], ['P2', 'P1']]
		end
	end


end
