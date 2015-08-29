require_relative '../libraries/mapr'

describe 'Mapr' do
  mi = Mapr

  describe '#has_mapr_role?' do

    node = {
      'hostalias' => 'node-1',
      'mapr' => {
        'nfs' => '*',
        'zk' => ['node-1'],
        'hs' => 'node-1',
        'rm' => ['node-2'],
        'foo' => 'node-2'
      }
    }

    it 'should return true when node is in role array' do
      expect(
        mi.role? node, 'zk'
      ).to be true
    end

    it 'should return true when node matches role string' do
      expect(
        mi.role? node, 'hs'
      ).to be true
    end

    it 'should return true when role value is *' do
      expect(
        mi.role? node, 'nfs'
      ).to be true
    end


    it 'should return false when node is not in role array' do
      expect(
        mi.role? node, 'rm'
      ).to be false
    end

    it 'should return false when node is not in role string' do
      expect(
        mi.role? node, 'foo'
      ).to be false
    end

    it 'should return false when role does not exist' do
      expect(
        mi.role? node, 'xyzzy'
      ).to be false
    end
  end
end
