# frozen_string_literal: true

describe SeleniumPage do
  let(:scheme_and_authority) { 'http://localhost:8080' }

  # reset the module state
  after do
    if described_class.instance_variable_defined?(:@scheme_and_authority)
      described_class.remove_instance_variable(:@scheme_and_authority)
    end
  end

  describe '.configure_scheme_and_authority' do
    it 'sets @scheme_and_authority' do
      described_class.configure_scheme_and_authority(scheme_and_authority)

      expect(described_class.instance_variable_get(:@scheme_and_authority))
        .to eql(scheme_and_authority)
    end

    context 'when param scheme_and_authority is not a string' do
      let(:scheme_and_authority) { 12_345 }

      it 'raises error' do
        expect do
          described_class.configure_scheme_and_authority(scheme_and_authority)
        end.to raise_error SeleniumPage::UnexpectedSchemeAndAuthorityError

        expect(described_class.instance_variable_get(:@scheme_and_authority))
          .to be(nil)
      end
    end
  end

  describe '.scheme_and_authority' do
    before do
      described_class.instance_variable_set(
        :@scheme_and_authority, scheme_and_authority
      )
    end

    it 'gets @scheme_and_authority' do
      expect(described_class.scheme_and_authority)
        .to eql(scheme_and_authority)
    end
  end
end
