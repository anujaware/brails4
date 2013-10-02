require 'spec_helper'

describe Question do
  before(:each) do
    @question = build(:question)
  end

  context "Fields" do
    it "has a field called 'Title'" do
      expect(@question).to have_field(:title).of_type(String)
    end
  end

  context "Validations" do
    it 'has a valid factory' do
      expect(@question).to be_valid
    end

    it 'is invalid without a title' do
      expect(build(:question, title: nil)).to_not be_valid
    end

    context 'Options' do
      it 'is invalid without options' do
        expect(build(:question,options: nil)).not_to be_valid
      end

      it 'is valid if has only one correct answer' do
        expect(build(:question, options: [build(:option), build(:incorrect_option), build(:incorrect_option)])).to be_valid
      end

      it "is invalid if more than one correct option is set" do
        expect(build(:question, options: [build(:option), build(:option), build(:option)])).not_to be_valid
      end

      it "is invalid if all options are incorrect" do
        expect(build(:question, options: [build(:incorrect_option), build(:incorrect_option), build(:incorrect_option)])).not_to be_valid
      end

      it 'has at least 3 options' do
        expect(@question.options.length).to be >= 3
      end

      it 'has at most 5 options' do
        expect(@question.options.length).to be < 5
      end
    end
  end

  context "Associations" do
    it 'has many embedded options' do
      expect(@question).to embed_many(:options)
    end

    it 'has many attempts' do
      expect(@question).to have_many(:attempts)
    end

    it 'has one difficulty' do
      expect(@question).to have_one(:difficulty)
    end
  end
end
