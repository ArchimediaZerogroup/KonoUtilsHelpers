# KonoUtilsHelpers

Collection of Classes used in KonoUtils

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'kono_utils_helpers'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install kono_utils_helpers

## Usage


### TmpFile
 Classe Funzionante prettamente con RAILS

 La classe si occupa dei files temporanei creando una cartella dentro a tmp del progetto,
 per ovviare al problema di duplicazioni dei nomi, viene generata una nuova cartella con
 timestamp univoco per ogni file.

 Estende Tempfile,
 la root della struttura è quella di Rails.root
 e di default la classe scrive dentro a tmp della root di rails.

 Non c'è bisogno di preoccuparsi di svuotare la cartella tmp contenente i file temporanei dato che la classe
 avrà l'onere di controllare e ripulire eventuali files dopo 1.day di default.

#### Utilizzo:
 tmp = KonoUtils::TmpFile.new('nomefile.ext')
 tmp.path -> path completa
 tmp.write(valore_da_scrivere_dentro_a_file)
 tmp.original_filename -> restituisce il nome inizialmente passato alla classe
 tmp.unique_filename   -> restoituisce il nome univoco del file
 tmp.path              -> restituisce la path del file



### Encoder
 Classe che si occupa di decodificare una qualsiasi stringa in formato utf8,
 cercando di trovare l'encoding iniziale a tentativi.
 Ha anche a disposizione una funzione per la rimozione dei caratteri BOM dalla stringa(http://en.wikipedia.org/wiki/Byte_order_mark)

#### Utilizzo
 str="stringa di un encoding sconosciuto"
 en = KonoUtils::Encoder.new(str)
 en.string_encoder  -> normale tentativo di encoding restituendo stringa in utf8
 en.remove_bom      -> rimozione del carattere BOM e encoding con la funzione precedente

### Percentage
 Classe che si occupa di rappresentare un numero in percentuale.
 Per maggiori info sulle funzionalità controllare la documentazione sulla classe

#### Utilizzo
 p = KonoUtils::Percentage.new(100,20)
 p.percentage -> ritorna il valore percentuale float
 p.to_i -> ritorna percentuale intera con relativi arrotondamenti
 p.to_percentage -> si comporta come l'helper number_to_percentage

### Params Hash Array

 Si occupa di trasformare un hash con elementi che sono chiramente array in un hash con elementi array:

 {"DatiOrdineAcquisto"=>{"0"=>{"RiferimentoNumeroLinea"=>{"0"=>""}, "IdDocumento"=>"", "Data"=>"", "NumItem"=>"", "CodiceCommessaConvenzione"=>"", "CodiceCUP"=>"", "CodiceCIG"=>""}}}
 {"DatiOrdineAcquisto"=>[{"RiferimentoNumeroLinea"=>[""], "IdDocumento"=>"", "Data"=>"", "NumItem"=>"", "CodiceCommessaConvenzione"=>"", "CodiceCUP"=>"", "CodiceCIG"=>""}]}

#### Utilizzo
 includere nel controller o dove si vuole utilizzare il concern
 include KonoUtils::ParamsHashArray

 e richiamare la funzione:
 elaborate_params_to_hash_array(params)

### Virtual Model
 Server per avere un modello virtuale in Rails

#### Utilizzo
  Praticamente è come avere un active record ma senza avere una tabella

  class Session < KonoUtils::VirtualModel

    attr_accessor :username, :password, :token


    validates :token,:presence=>true

  end

  Session.new(:username=>'ciao',:password=>'pippo').valid? => false

