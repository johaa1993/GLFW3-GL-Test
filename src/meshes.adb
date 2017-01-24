with GL.Vertex_Attributes;
with System;
with GL.C;

package body Meshes is

   procedure Setup (Item : in out Mesh) is
      use GL;
      use GL.Vertex_Array_Objects;
      use GL.Vertex_Attributes;
      use System;
      use GL.Buffers;
      Pos_Loc_Index : constant Vertex_Attributes.Index := Create_Index (0);
      Col_Loc_Index : constant Vertex_Attributes.Index := Create_Index (1);
      Stride : constant Natural := Vertex_Array'Component_Size / Storage_Unit;
   begin
      Bind (Buffers.Array_Slot, Item.Buffer_Name);
      Bind (Item.Vertex_Array_Name);
      Set_Memory_Layout (Pos_Loc_Index, Float_Vector3'Length, Float_Type, False, Stride, 0);
      Set_Memory_Layout (Col_Loc_Index, Float_Vector4'Length, Float_Type, False, Stride, Float_Vector3'Size / Storage_Unit);
      Enable (Pos_Loc_Index);
      Enable (Col_Loc_Index);
      Item.Dummy := True;
   end;


   procedure Draw (Item : Mesh) is
      use GL.Vertex_Array_Objects;
   begin
      Bind (Item.Vertex_Array_Name);
      GL.Drawings.Draw (Item.Draw_Mode, 0, Integer (Item.Data.Last));
   end;


   procedure Make_Triangle (Item : in out Mesh) is
      use GL;
      use GL.Buffers;
      use type GL.C.GLfloat;
      use Vertex_Vectors;
   begin
      Item.Draw_Mode := GL.Drawings.Triangles_Mode;
      Append (Item.Data, Vertex'((0.5, -0.5, 0.0), (1.0, 0.0, 0.0, 1.0)));
      Append (Item.Data, Vertex'((-0.5, -0.5, 0.0), (0.0, 1.0, 0.0, 1.0)));
      Append (Item.Data, Vertex'((0.0,  0.5, 0.0), (0.0, 0.0, 1.0, 1.0)));
      Bind (Array_Slot, Item.Buffer_Name);
      Allocate_Uninitialized_Bits (Array_Slot, Data_Size (Item.Data), Static_Usage);
      Redefine_Bits (Array_Slot, 0, Data_Size (Item.Data), Data_Address (Item.Data));
--        declare
--           X : Vertex_Array (1 .. Integer (Item.Data.Length)) with Address => Item.Data'Address;
--        begin
--           Put (X);
--        end;
   end;

   procedure Make_Grid_Lines (Item : in out Mesh) is
      use GL;
      use GL.Buffers;
      use Vertex_Vectors;
      D : constant GLfloat := 10.0;
   begin
      --Item.Draw_Mode := GL.Drawings.Line_Strip_Mode;
      Item.Draw_Mode := GL.Drawings.Lines_Mode;
      for I in 1 .. 10 loop
         Append (Item.Data, Vertex'((0.0, 0.0, GLfloat (I)), (0.0, 0.0, 1.0, 1.0)));
         Append (Item.Data, Vertex'((D, 0.0, GLfloat (I)), (0.0, 0.0, 1.0, 1.0)));
         Append (Item.Data, Vertex'((GLfloat (I), 0.0, 0.0), (0.0, 0.0, 1.0, 1.0)));
         Append (Item.Data, Vertex'((GLfloat (I), 0.0, D), (0.0, 0.0, 1.0, 1.0)));
      end loop;


      Bind (Array_Slot, Item.Buffer_Name);
      Allocate_Uninitialized_Bits (Array_Slot, Data_Size (Item.Data), Static_Usage);
      Redefine_Bits (Array_Slot, 0, Data_Size (Item.Data), Data_Address (Item.Data));
   end;


   procedure Make_Sin (Item : in out Mesh) is
      use GL;
      use GL.Buffers;
      use Vertex_Vectors;
   begin
      Item.Draw_Mode := GL.Drawings.Line_Strip_Mode;
      for I in 1 .. 40 loop
         Append (Item.Data, Vertex'((0.0, Elementary_Functions.Sin (GLfloat (I)), GLfloat (I)), (0.0, 1.0, 1.0, 1.0)));
      end loop;

      Bind (Array_Slot, Item.Buffer_Name);
      Allocate_Uninitialized_Bits (Array_Slot, Data_Size (Item.Data), Static_Usage);
      Redefine_Bits (Array_Slot, 0, Data_Size (Item.Data), Data_Address (Item.Data));
   end;

end;
