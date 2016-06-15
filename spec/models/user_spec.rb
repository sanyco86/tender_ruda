describe User do
  describe '#prepend_www' do
    context 'when site is without protocol' do
      it 'prepends it with "http://"' do
        subject = described_class.new(www: 'ya.ru')
        subject.valid?
        expect(subject.www).to eq 'http://ya.ru'
      end
    end

    context 'when site is empty string' do
      it 'does not change' do
        subject = described_class.new(www: '')
        subject.valid?
        expect(subject.www).to eq ''
      end
    end

    context 'when site is with "https" protocol' do
      it 'does not change' do
        subject = described_class.new(www: 'https://ya.ru')
        subject.valid?
        expect(subject.www).to eq 'https://ya.ru'
      end
    end

    context 'when site is with "http" schema' do
      it 'does not change' do
        subject = described_class.new(www: 'http://ya.ru')
        subject.valid?
        expect(subject.www).to eq 'http://ya.ru'
      end
    end
  end
end
