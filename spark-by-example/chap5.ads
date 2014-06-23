--  This package provides an implementation of case studies from the
--  "ACSL by Example" technical report, chapter 5, from
--  http://www.fokus.fraunhofer.de/de/sqc/_download_sqc/ACSL-by-Example.pdf

generic
   type T is (<>);

package Chap5 is

   type Index_T is range 0 ..10;
   subtype Index is Index_T range 1 .. 10;

   type T_Arr is array (Index) of T;

   --  Is_Sorted predicate

   function Is_Sorted (A : T_Arr) return Boolean is
      (for all J in A'Range =>
         (for all K in J + 1 .. A'Last => A (J) <= A (K)));

   --  5.1 The 'lower_bound' algorithm
   --
   --  lower_bound will return the largest index i with 0 <= i <= n
   --  such that for each indexk with 0 <= k < i the condition
   --  a[k] < val holds.
   --
   --  * If lower_bound returns n then for each index 0 <= i < n holds
   --    a[i] < val. Thus, val is not contained in a.
   --
   --  * If, however, lower_bound returns an index 0 <= i < n then we
   --    can only be sure that val <= a[i] holds.

   function Lower_Bound (A : T_Arr; Val : T) return Index_T
     with Pre => (Is_Sorted (A)),
     Post =>
     (if Lower_Bound'Result in A'Range then
       (for all K in A'First .. Lower_Bound'Result - 1 => A (K) < Val) and
       (for all K in Lower_Bound'Result .. A'Last => A(K) >= Val));

end Chap5;
