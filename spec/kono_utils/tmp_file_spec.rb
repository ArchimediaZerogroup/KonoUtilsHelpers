require_relative '../spec_helper'

module KonoUtils
  RSpec.describe TmpFile do

    it "alla fine dell'utilizzo il file non viene cancellato" do

      tmp = TmpFile.new('nomefile.ext')
      path = tmp.path
      tmp.write('ciao')
      tmp.fsync
      tmp.close
      expect(File.exist?(path)).to be_truthy
      TmpFile.new('new_file.ext')
      expect(File.exist?(path)).to be_truthy

    end

    it "viene cancellato il file superato il tempo di attesa al prossimo riutilizzo" do

      freeze_time
      tmp = TmpFile.new('nomefile.ext')
      expect(File.exist?(tmp.path)).to be_truthy
      travel_to(Time.now + TmpFile::TIME_LIMIT)
      nuovo = TmpFile.new('NEWnomefile.ext')
      expect(File.exist?(tmp.path)).to be_truthy
      expect(File.exist?(nuovo.path)).to be_truthy
      travel_to(Time.now + 1)
      nuovo2 = TmpFile.new('NEWnomefile.ext')
      expect(File.exist?(tmp.path)).not_to be_truthy
      expect(File.exist?(nuovo.path)).to be_truthy
      expect(File.exist?(nuovo2.path)).to be_truthy
      travel_back

    end
  end

end
