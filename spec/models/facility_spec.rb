require 'rails_helper'

RSpec.describe Facility, type: :model do

  describe 'Factory' do
    it 'is valid' do
      expect(FactoryGirl.create(:facility)).to be_valid
    end
  end

  describe 'DB table' do
    it { is_expected.to have_db_column :id }
    it { is_expected.to have_db_column :name }
    it { is_expected.to have_db_column :code }
    it { is_expected.to have_db_column :address }
    it { is_expected.to have_db_column :post_code }
    it { is_expected.to have_db_column :city }
    it { is_expected.to have_db_column :country }
  end

  describe 'Associations' do
    it { is_expected.to have_many :users }
    it { is_expected.to have_many :resources }
  end

  describe 'Validations' do
    it { is_expected.to validate_presence_of :name }
    it { is_expected.to validate_length_of(:code).is_equal_to(4) }

  end

  describe '#full_address returns sanitized address from Google' do
    let(:facility) { create(:facility, address: 'Holtermansgatan 1', post_code: '411 10', city: 'Gothenburg')}

    it 'returns full address' do
      expect(facility.full_address).to eq 'Holtermansgatan 1, 411 29 Göteborg, Sweden'
    end
  end
end
