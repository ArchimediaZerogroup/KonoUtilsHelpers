require_relative '../spec_helper'

module KonoUtils
  RSpec.describe TmpFile do

    it "alla fine dell'utilizzo il file non viene cancellato" do

      tmp = TmpFile.new('nomefile.ext')
      path = tmp.path
      tmp.write('ciao')
      tmp.fsync
      tmp.close
      # sostituendo la variabile con un nuovo oggetto, l'oggetto principale iniziale finisce nel
      # garbage collector
      tmp = TmpFile.new('new_file.ext')
      GC.start
      expect(File.exist?(tmp.path)).to be_truthy
      expect(File.exist?(path)).to be_truthy

    end

    it "viene cancellato il file superato il tempo di attesa al prossimo riutilizzo" do

      freeze_time
      tmp = TmpFile.new('nomefile.ext')
      tmp_path = tmp.path
      expect(File.exist?(tmp_path)).to be_truthy
      travel_to(Time.now + TmpFile::TIME_LIMIT-10)
      tmp = TmpFile.new('NEWnomefile.ext')
      nuovo_path = tmp.path
      expect(File.exist?(tmp_path)).to be_truthy
      expect(File.exist?(nuovo_path)).to be_truthy
      travel_to(Time.now + 1)
      tmp = TmpFile.new('NEWnomefile.ext')
      nuovo2_path = tmp.path
      expect(File.exist?(tmp_path)).to be_falsey
      expect(File.exist?(nuovo_path)).to be_truthy
      expect(File.exist?(nuovo2_path)).to be_truthy
      travel_back

    end
  end

end
