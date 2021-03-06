require 'fileutils'
require 'tempfile'
module KonoUtils
  ##
  # Classe Funzionante prettamente con RAILS
  # la classe si occupa dei files temporanei creando una cartella dentro a tmp del progetto
  # crea una cartella random per ogni file per ovviare al problema di duplicazioni dei nomi
  # Estende Tempfile,
  # la root della struttura è quella di Rails.root
  # e di default la classe scrive dentro a tmp
  # non ha bisogno di essere cancellata, ci penserà in automatico la classe una
  # la prossima volta che viene chiamata cancellando tutti i files con un TTL
  # maggiore di 1.day di default
  ## Utilizzo:
  # tmp = TmpFile.new('nomefile.ext')
  # tmp.path -> path completa
  # tmp.write.....
  # tmp.original_filename.......
  # tmp.unique_filename.......
  #
  #
  class TmpFile

    PATH = 'tmp/ptmpfile'
    TIME_LIMIT = 1 * 60 * 60 * 24 # 1day
    attr_accessor :root_dir
    attr_accessor :tmp_dir
    attr_accessor :original_filename, :unique_filename
    attr_accessor :tmp_file

    ##
    # Generate a new file with a given name
    #
    # * *Args*    :
    #   - name -> String of the name file
    # * *Returns* :
    #   - Tempfile
    #
    def initialize(name)
      self.original_filename = name
      self.root_dir = controll_root
      clean_tmpdir
      #creo una nuova cartella per il file attuale
      self.tmp_dir = "#{self.root_dir.path}/#{Time.now.to_f}"
      Dir.mkdir(self.tmp_dir)
      ext = File.extname(name)
      name = [File.basename(name), ext] unless ext.blank?

      @tmp_file = Tempfile.create(name, self.tmp_dir)

      self.unique_filename= File.basename(self.path)
    end

    delegate_missing_to :@tmp_file

    def unlink
      File.unlink(@tmp_file.path)
    rescue Errno::ENOENT
    rescue Errno::EACCES
      # may not be able to unlink on Windows; just ignore
      return
    end

    private

    ##
    # controll presence of root dir
    # if not exists create it
    # * *Returns* :
    #   - Dir
    #
    def controll_root
      root = '/'
      if defined?("::Rails")
        if Rails.respond_to?(:root)
          root = ::Rails.root
        end
      end
      root = File.join(root, PATH)
      unless File.exist?(root)
        Dir.mkdir(root)
      end
      Dir.open(root)
    end

    ##
    # Clean the directory
    #
    def clean_tmpdir
      self.root_dir.each do |d|
        # controlliamo il nome del file. in quanto il nome del file coincide al Time.now
        if d != '..' and d != '.'
          if d.to_i < Time.now.to_i - TIME_LIMIT
            FileUtils.rm_rf(File.join(self.root_dir.path, d))
          end
        end
      end
    end

  end
end