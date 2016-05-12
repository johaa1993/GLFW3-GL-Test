with GL.C;
with Generic_Maths;

package Maths is

   use Generic_Maths;

   type Element is new GL.C.GLfloat;
   type Degree is new Element;
   type Radian is new Element;

   subtype Dimension is Integer;
   subtype Dimension_3 is Dimension range 1 .. 3;
   subtype Dimension_4 is Dimension range 1 .. 4;
   subtype Dimension_Quaternion is Dimension range 1 .. 4;

   type Vector is array (Dimension range <>) of Element;
   type Vector_3 is new Vector (Dimension_3);
   type Vector_4 is new Vector (Dimension_4);
   type Quaternion is new Vector (Dimension_Quaternion);

   type Matrix is array (Dimension range <>, Dimension range <>) of Element;
   type Matrix_Square is new Matrix;-- with Dynamic_Predicate => Matrix_Square'Length (1) = Matrix_Square'Length (2);
   type Matrix_3 is new Matrix_Square (Dimension_3, Dimension_3);
   type Matrix_4 is new Matrix_Square (Dimension_4, Dimension_4);

   type Matrix_RC is new Matrix;
   type Matrix_RC_Square is new Matrix_Square;
   type Matrix_RC_3 is new Matrix_3;
   type Matrix_RC_4 is new Matrix_4;

   type Matrix_CR is new Matrix;
   type Matrix_CR_Square is new Matrix_Square;
   type Matrix_CR_3 is new Matrix_3;
   type Matrix_CR_4 is new Matrix_4;

   type Axis is new Vector_3;

   function Length2 is new Generic_Length2_Unconstrained (Dimension, Element, Vector);
   function Length2 is new Generic_Length2_Constrained (Dimension_3, Element, Vector_3);
   function Length2 is new Generic_Length2_Constrained (Dimension_4, Element, Vector_4);
   function Length2 is new Generic_Length2_Constrained (Dimension_Quaternion, Element, Quaternion);

   function Length is new Generic_Length_Unconstrained (Dimension, Element, Vector);
   function Length is new Generic_Length_Constrained (Dimension_3, Element, Vector_3);
   function Length is new Generic_Length_Constrained (Dimension_4, Element, Vector_4);
   function Length is new Generic_Length_Constrained (Dimension_Quaternion, Element, Quaternion);

   procedure Scale is new Generic_Scale_Unconstrained (Dimension, Element, Vector);
   procedure Scale is new Generic_Scale_Constrained (Dimension_3, Element, Vector_3);
   procedure Scale is new Generic_Scale_Constrained (Dimension_4, Element, Vector_4);
   procedure Scale is new Generic_Scale_Constrained (Dimension_Quaternion, Element, Quaternion);

   procedure Normalize is new Generic_Normalize_Unconstrained (Dimension, Element, Vector);
   procedure Normalize is new Generic_Normalize_Constrained (Dimension_3, Element, Vector_3);
   procedure Normalize is new Generic_Normalize_Constrained (Dimension_4, Element, Vector_4);
   procedure Normalize is new Generic_Normalize_Constrained (Dimension_Quaternion, Element, Quaternion);

   procedure Set_Diagonal is new Generic_Set_Diagonal_Square_Matrix_Unconstrained (Dimension, Element, Matrix);
   procedure Set_Diagonal is new Generic_Set_Diagonal_Square_Matrix_Unconstrained (Dimension, Element, Matrix_Square);
   procedure Set_Diagonal is new Generic_Set_Diagonal_Square_Matrix_Constrained (Dimension_3, Element, Matrix_3);
   procedure Set_Diagonal is new Generic_Set_Diagonal_Square_Matrix_Constrained (Dimension_4, Element, Matrix_4);
   procedure Set_Diagonal is new Generic_Set_Diagonal_Square_Matrix_Unconstrained (Dimension, Element, Matrix_RC);
   procedure Set_Diagonal is new Generic_Set_Diagonal_Square_Matrix_Unconstrained (Dimension, Element, Matrix_RC_Square);
   procedure Set_Diagonal is new Generic_Set_Diagonal_Square_Matrix_Constrained (Dimension_3, Element, Matrix_RC_3);
   procedure Set_Diagonal is new Generic_Set_Diagonal_Square_Matrix_Constrained (Dimension_4, Element, Matrix_RC_4);
   procedure Set_Diagonal is new Generic_Set_Diagonal_Square_Matrix_Unconstrained (Dimension, Element, Matrix_CR);
   procedure Set_Diagonal is new Generic_Set_Diagonal_Square_Matrix_Unconstrained (Dimension, Element, Matrix_CR_Square);
   procedure Set_Diagonal is new Generic_Set_Diagonal_Square_Matrix_Constrained (Dimension_3, Element, Matrix_CR_3);
   procedure Set_Diagonal is new Generic_Set_Diagonal_Square_Matrix_Constrained (Dimension_4, Element, Matrix_CR_4);

   function Unit is new Generic_Create_Unit_Matrix_Constrained (Dimension_3, Element, Matrix_3);
   function Unit is new Generic_Create_Unit_Matrix_Constrained (Dimension_4, Element, Matrix_4);
   function Unit is new Generic_Create_Unit_Matrix_Constrained (Dimension_3, Element, Matrix_RC_3);
   function Unit is new Generic_Create_Unit_Matrix_Constrained (Dimension_4, Element, Matrix_RC_4);
   function Unit is new Generic_Create_Unit_Matrix_Constrained (Dimension_3, Element, Matrix_CR_3);
   function Unit is new Generic_Create_Unit_Matrix_Constrained (Dimension_4, Element, Matrix_CR_4);

   function "*" is new Generic_Constrained_Square_Matrix_Multiply (Dimension_3, Element, Matrix_RC_3, False);
   function "*" is new Generic_Constrained_Square_Matrix_Multiply (Dimension_4, Element, Matrix_RC_4, False);
   function "*" is new Generic_Constrained_Square_Matrix_Multiply (Dimension_3, Element, Matrix_CR_3, True);
   function "*" is new Generic_Constrained_Square_Matrix_Multiply (Dimension_4, Element, Matrix_CR_4, True);


   function "+" is new Generic_Constrained_Vector_Add_Return (Dimension_3, Element, Vector_3);
   function "+" is new Generic_Constrained_Vector_Add_Return (Dimension_4, Element, Vector_4);
   function "+" is new Generic_Constrained_Vector_Add_Return (Dimension_Quaternion, Element, Quaternion);

   procedure Multiply_Accumulate is new Generic_Constrained_Scalar_Vector_Multiply_Accumulate (Dimension_3, Element, Vector_3);

   function Unit return Quaternion is (1.0, 0.0, 0.0, 0.0);

   procedure Convert (Revolve : Axis; Angle : Radian; Result : out Quaternion);
   function Convert (Revolve : Axis; Angle : Radian) return Quaternion;
   function Convert (Revolve : Axis; Angle : Degree) return Quaternion;

   function Convert (Angle : Radian) return Degree;
   function Convert (Angle : Degree) return Radian;

   procedure Hamilton_Product (Left, Right : Quaternion; Result : out Quaternion);
   function Hamilton_Product (Left, Right : Quaternion) return Quaternion;


   function Hadamard_Product is new Generic_Constrained_Vector_Vector_Hadamard_Product_Return (Dimension_3, Element, Vector_3);


   procedure Convert (Item : Quaternion; Result : out Matrix_4);
   function Convert (Item : Quaternion) return Matrix_4;


   procedure Make_Translation (Item : in out Matrix_RC_4; Translation : Vector_3);
   procedure Make_Translation (Item : in out Matrix_CR_4; Translation : Vector_3);

   procedure Put (Item : Matrix_CR);
   procedure Put (Item : Matrix_RC);
   procedure Put (Item : Vector);

end;