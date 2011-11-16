module Mustererkennung
  module Constants
    LOCAL_PATH  = "#{File.dirname(__FILE__)}/../examples/pendigits-training.txt"

    REMOTE_PATH = 'http://www.inf.fu-berlin.de/lehre/WS11/ME/uebungen/uebung01/pendigits-training.txt'

    FILE_NAME = if File.exists?(LOCAL_PATH)
        LOCAL_PATH
      else
        REMOTE_PATH
      end

    DEFAULT_K = 10

    CONVERGENCE_ITERATION = 10
  end
end

