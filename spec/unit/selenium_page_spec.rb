# frozen_string_literal: true

describe SeleniumPage do
  let(:scheme_and_authority) { 'http://localhost:8080' }
  let(:wait_time) { 5 }

  # reset the module state
  after do
    described_class.instance_variable_set(:@wait_time, 10)
    if described_class.instance_variable_defined?(:@scheme_and_authority)
      described_class.remove_instance_variable(:@scheme_and_authority)
    end
  end

  describe '@wait_time' do
    it 'has a default value' do
      expect(described_class.instance_variable_get(:@wait_time)).to be(10)
    end
  end

  describe '.configure_scheme_and_authority' do
    context 'when param scheme_and_authority is not a string' do
      let(:scheme_and_authority) { 12_345 }

      it 'raises error' do
        expect do
          described_class.configure_scheme_and_authority(scheme_and_authority)
        end.to raise_error SeleniumPage::Errors::UnexpectedSchemeAndAuthority

        expect(described_class.instance_variable_get(:@scheme_and_authority))
          .to be(nil)
      end
    end

    it 'sets @scheme_and_authority' do
      described_class.configure_scheme_and_authority(scheme_and_authority)

      expect(described_class.instance_variable_get(:@scheme_and_authority))
        .to eql(scheme_and_authority)
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

  describe '.configure_wait_time' do
    context 'when param wait_time is not a Numeric' do
      let(:wait_time) { '12345' }

      it 'raises error' do
        expect { described_class.configure_wait_time(wait_time) }
          .to raise_error SeleniumPage::Errors::UnexpectedWaitTime

        expect(described_class.instance_variable_get(:@wait_time))
          .to be(10)
      end
    end

    it 'sets @wait_time' do
      described_class.configure_wait_time(wait_time)

      expect(described_class.instance_variable_get(:@wait_time))
        .to eql(wait_time)
    end
  end

  describe '.wait_time' do
    it 'gets default @wait_time' do
      expect(described_class.wait_time)
        .to be(10)
    end

    it 'gets configured @wait_time' do
      described_class.instance_variable_set(:@wait_time, wait_time)
      expect(described_class.wait_time)
        .to be(wait_time)
    end
  end
end
