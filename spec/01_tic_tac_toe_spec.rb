require_relative '../lib/tic_tac_toe.rb'

describe './lib/tic_tac_toe.rb' do
  describe 'WIN_COMBINATIONS' do
    it 'defines a constant WIN_COMBINATIONS with arrays for each win combination' do
      expect(WIN_COMBINATIONS.size).to eq(8)

      expect(WIN_COMBINATIONS).to include([0,1,2])
      expect(WIN_COMBINATIONS).to include([3,4,5])
      expect(WIN_COMBINATIONS).to include([6,7,8])
      expect(WIN_COMBINATIONS).to include([0,3,6])
      expect(WIN_COMBINATIONS).to include([1,4,7])
      expect(WIN_COMBINATIONS).to include([2,5,8])
      expect(WIN_COMBINATIONS).to include([0,4,8])
      expect(WIN_COMBINATIONS).to include_array([6,4,2])
    end
  end
end
