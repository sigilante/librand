  ::
::::  Random list library
::
::
/+  seq
|%
::    +shuffle: (list T) -> (list T)
::
::  Reorder the elements of a list randomly using the Fisher-Yates algorithm.
::    Examples
::      > (shuffle `(list @)`~[1 2 3 4 5] eny)
::      ~[3 1 5 2 4]
::      > (shuffle `(list @)`~[1 2 3 4 5 6 7 8 9] eny)
::      ~[5 2 9 1 8 4 3 7 6]
::  Source
++  shuffle
  |*  [a=(list) eny=@uvJ]
  =/  n  (lent a)
  =/  i  0
  =/  rng  ~(. og eny)
  |-  ^-  (list _?>(?=(^ a) i.a))
  ?:  =(n i)  a
  =^  r  rng  (rads:rng n)
  =/  i1  (snag i a)
  =/  i2  (snag r a)
  =.  a  (snap a i i2)
  =.  a  (snap a r i1)
  $(i +(i))
::    +sample: (list T) -> (list T)
::
::  Select a random subset from a list.
::    Examples
::      > (sample `(list @)`~[1 2 3 4 5] 3 eny)
::      ~[3 1 5]
::      > (sample `(list @)`~[1 2 3 4 5] 3 eny)
::      ~[2 4 5]
::  Source
++  sample
  |*  [a=(list) n=@ eny=@uvJ]
  ^-  (list _?>(?=(^ a) i.a))
  =.  n  (min (lent a) n)
  =/  b  (shuffle a eny)
  (scag n b)
::    +draw: (list T) -> T
::
::  Select a random element from a list.
::    Examples
::      > (draw `(list @)`~[1 2 3 4 5] eny)
::      3
::      > (draw `(list @)`~[1 2 3 4 5] eny)
::      5
::  Source
++  draw
  |*  [a=(list) eny=@uvJ]
  ^-  _?>(?=(^ a) i.a)
  =/  n  (lent a)
  =/  rng  ~(. og eny)
  =^  r  rng  (rads:rng n)
  (snag r a)
::    +draw-n: (list T) -> (list T)
::
::  Select a random subset from a list.
::    Examples
::      > (draw-n `(list @)`~[1 2 3 4 5] 3 eny)
::      ~[3 1 5]
::      > (draw-n `(list @)`~[1 2 3 4 5] 3 eny)
::      ~[2 4 5]
::  Source
++  draw-n  sample
::    +draw-with-replacement: (list T) -> (list T)
::
::  Select random elements from a list, with replacement.
::    Examples
::      > (draw-with-replacement `(list @)`~[1 2 3 4 5] 3 eny)
::      ~[3 1 5]
::      > (draw-with-replacement `(list @)`~[1 2 3 4 5] 3 eny)
::      ~[2 4 2]
::  Source
++  draw-n-with-replacement
  |*  [a=(list) n=@ eny=@uvJ]
  ^-  (list _?>(?=(^ a) i.a))
  =/  i  0
  =|  b=(list _?>(?=(^ a) i.a))
  =/  rng  ~(. og eny)
  |-
  ?:  =(n i)  b
  =^  r  rng  (rads:rng (lent a))
  =/  bb  (snag r a)
  $(i +(i), b [bb b])
::
::  Distributions
::
++  rs
  ^|
  |%
  ::    +mt19937: @rs -> core
  ::
  ::  Create a new random number generator.
  ::    Examples
  ::      > (mt19937 123456789)
  ::      @rs
  ::  Source
  ++  mt19937
    |=  seed=@rs
    :: TODO look at the +og implementation

:: Algorithm mt19937 (Mersenne Twister):

:: Initialization:
:: - Define parameters:
::   - w: word size (32 bits in mt19937)
::   - n: degree of recurrence
::   - m: middle word, an offset used in the recurrence relation
::   - r: separation point of one word, used to scramble bits
::   - a, b, c: coefficients of the recurrence
::   - s, t: tempering bitmasks
::   - u, d, l: tempering bit shifts
::   - f: constant for tempering
::   - lower_mask, upper_mask: bitmasks to extract the lowest and upper bits

:: - Initialize the state vector mt[0..n-1] with a seed value.
:: - Set index m to n + 1.

:: Generation of pseudorandom numbers:
:: - If index m is greater than or equal to n, update the state vector:
::   - For i from 0 to n-1:
::     - y = (mt[i] & upper_mask) | (mt[(i+1) % n] & lower_mask)
::     - mt[i] = mt[(i + m) % n] ^ (y >> 1) ^ (y & 0x1U) << (w - 1)
::   - Set m to 0.

:: - Extract a tempered value based on the state vector:
::   - y = mt[m]
::   - y = y ^ (y >> u)
::   - y = y ^ ((y << s) & b)
::   - y = y ^ ((y << t) & c)
::   - y = y ^ (y >> l)

:: - Increment m.

:: - Return the tempered value y.

  ::    +uniform: (num) -> num
  ::
  ::  Generate a random number between 0 and 1.
  ::    Examples
  ::      > (uniform eny)
  ::      0.123456789
  ::      > (uniform eny)
  ::      0.987654321
  ::  Source
  ++  uniform

  --
++  uniform  !!
++  normal   !!
--
