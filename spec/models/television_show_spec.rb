require "spec_helper"

describe TelevisionShow do
  let(:load) {
    CSV.open('television-shows.csv', 'a') do |file|
      title = "Friends"
      network = "NBC"
      starting_year = "1994"
      synopsis = "Six friends living in New York city"
      genre = "Comedy"
      data = [title, network, starting_year, synopsis, genre]
      file.puts(data)
    end }

  describe ".new" do
   it "creates TelevisionShow object" do
     expect(TelevisionShow.new).to be_a(TelevisionShow)
   end
  end

  describe "#unique_tv_show_title" do
    it "it checks if TV Show title entered by user is unique" do
      load

      tv_show = {"title" => "Friends", "network" => "nbc", "starting_year" => "1994", "synopsis" => "funny", "genre" => "Comedy"}
      add_show = TelevisionShow.new(tv_show)
      expect(add_show.unique_tv_show_title).to eq(false)

      tv_show = {"title" => "Hello", "network" => "nbc", "starting_year" => "1994", "synopsis" => "funny", "genre" => "Comedy"}
      add_show = TelevisionShow.new(tv_show)
      expect(add_show.unique_tv_show_title).to eq(true)
    end
  end

  describe "#errors?" do
    it "checks if any input field is empty" do
      tv_show = {"title" => "Friends", "network" => "nbc", "starting_year" => "1994", "synopsis" => "funny", "genre" => ""}
      test_show = TelevisionShow.new(tv_show)
      expect(test_show.errors?).to eq(true)


      tv_show = {"title" => "Friends", "network" => "nbc", "starting_year" => "1994", "synopsis" => "funny", "genre" => "Comedy"}
      test_show = TelevisionShow.new(tv_show)
      expect(test_show.errors?).to eq(false)

      expect(TelevisionShow.new.errors?).to eq(false)
    end
  end

  describe "#valid?" do
    it "checks if user input is error free and valid to save" do
      tv_show = {"title" => "Friends", "network" => "nbc", "starting_year" => "1994", "synopsis" => "funny", "genre" => ""}
      test_show = TelevisionShow.new(tv_show)
      expect(test_show.valid?).to eq(false)

      tv_show = {"title" => "Friends", "network" => "nbc", "starting_year" => "", "synopsis" => "funny", "genre" => "Comedy"}
      test_show = TelevisionShow.new(tv_show)
      expect(test_show.valid?).to eq(false)

      tv_show = {"title" => "Friends", "network" => "nbc", "starting_year" => "1994", "synopsis" => "funny", "genre" => "Comedy"}
      test_show = TelevisionShow.new(tv_show)
      expect(test_show.valid?).to eq(true)
    end
  end

  describe "#save" do
    it "checks if user input is error free and valid to save" do
      tv_show = {"title" => "Friends", "network" => "nbc", "starting_year" => "1994", "synopsis" => "funny", "genre" => ""}
      test_show = TelevisionShow.new(tv_show)
      expect(test_show.save).to be(false)

      tv_show = {"title" => "Friends", "network" => "nbc", "starting_year" => "", "synopsis" => "funny", "genre" => "Comedy"}
      test_show = TelevisionShow.new(tv_show)
      expect(test_show.save).to be(false)

      tv_show = {"title" => "Friends", "network" => "nbc", "starting_year" => "1994", "synopsis" => "funny", "genre" => "Comedy"}
      test_show = TelevisionShow.new(tv_show)
      expect(test_show.save).to eq(true)
    end
  end

  describe "#self.all" do
    it "returns array of TelevisionShow objects for all tv shows in csv file" do
      load
      tv_show = {"title" => "Rope", "network" => "nbc", "starting_year" => "1994", "synopsis" => "funny", "genre" => "Comedy"}
      test_show = TelevisionShow.new(tv_show)
      test_show.save

      array = []
      array = TelevisionShow.all

      expect(array.length).to be(2)
      expect(array[0].title).to include("Friends")
      expect(array[1].title).to include("Rope")
    end
  end
end
