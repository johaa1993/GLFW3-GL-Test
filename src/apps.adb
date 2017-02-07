with GL.C.Initializations;
with OpenGL_Loader_Test;
with Shaders;
with GL.Programs.Uniforms;
--with OS_Systems;
--with Maths;

with Ada.Text_IO;
with Ada.Strings;
with Ada.Strings.Fixed;
-- with Ada.Integer_Text_IO;
with System;
with System.Address_Image;
with Ada.Unchecked_Conversion;
with System.Storage_Elements;

package body Apps is

   procedure Key_Callback (W : GLFW3.Window; K : GLFW3.Windows.Keys.Key; Scancode : Interfaces.C.int; A : GLFW3.Windows.Keys.Key_Action; Mods : Interfaces.C.int) is
      pragma Unreferenced (Mods, Scancode);
      use Ada.Text_IO;
      use Ada.Strings.Fixed;
      --use Ada.Integer_Text_IO;
      use System;
      procedure Put_Address (A : Address) is
      begin
         Put (Address_Image (A));
      end;
      procedure Put_Column (S : String) is
      begin
         Put (Head (S, 30));
      end;
      type App_Access is access all App;
      function Convert is new Ada.Unchecked_Conversion (Address, App_Access);
      Main_App : access App := Convert (GLFW3.Windows.Get_Window_User_Pointer (W));
   begin
      if A = Key_Action_Press then
         case K is
            when Key_Kp_Add =>
               --Put_Column ("App'Address");
               --pragma Assert (Main_App.Check_Sum = 555);
               Ada.Text_IO.Put_Line (Main_App.Check_Sum'Img);
               Put_Address (GLFW3.Windows.Get_Window_User_Pointer (W));
               null;
--           when Key_Kp_0 =>
--              Parse_Handler.Hide (0);
--           when Key_Kp_1 =>
--              Parse_Handler.Hide (1);
--           when Key_Kp_2 =>
--              Parse_Handler.Hide (2);
--           when Key_Kp_3 =>
--              Parse_Handler.Hide (3);
--           when Key_Kp_4 =>
--              Parse_Handler.Hide (4);
--           when Key_Kp_5 =>
--              Parse_Handler.Hide (5);
--           when Key_Kp_6 =>
--              Parse_Handler.Hide (6);
         when others =>
            null;
         end case;
      end if;
   end;


   procedure Input_Controller (Item : in out App) is
   begin
      Inputs.Get_Camera_Input (Item.Main_Window, Item.Main_Camera);
      Inputs.Get_Rotation_Input (Item.Main_Window, Item.Main_Camera.Rotation);
      Inputs.Get_Translation_Input (Item.Main_Window, Item.Main_Camera.Translation_Velocity);
      Cameras.Update (Item.Main_Camera);
   end;


   task body Info_Task is
      --package Time_Span_IO is new Ada.Text_IO.Integer_IO (Duration);
      --use Time_Span_IO;
      use Ada.Text_IO;
   begin
      accept Start;
      loop
         Put ("Time span :");
         Put (Duration'Image (To_Duration (A.Main_Time_Span / A.Main_Frame_Counter)));
         New_Line;
         --Put ("Frame counter :");
         --Put (Natural'Image (A.Main_Frame_Counter));
         --New_Line;
         --Inputs.Put_State (A.Main_Window, A.Main_Binding_Array);
--           OS_Systems.Clear_Screen;
--           Put (A.Main_Camera.Projection_Matrix);
--           New_Line;
--           Put (A.Main_Camera.Rotation_Matrix);
--           New_Line;
--           Put (A.Main_Camera.Translation_Matrix);
--           New_Line;
--           Put (A.Main_Camera.Result_Matrix);
--           New_Line;
         A.Main_Time_Span := A.Main_Time_End - A.Main_Time_Start;
         A.Main_Frame_Counter := 1;
         delay 1.0;
         select
            accept Quit;
            exit;
         else
            null;
         end select;
      end loop;
   end;


   task body Controller_Task is
   begin
      accept Start;
      loop
         Input_Controller (A.all);
         delay 0.01;
         select
            accept Quit;
            exit;
         else
            null;
         end select;
      end loop;
   end;


   procedure Debug_App (Item : in out App) is
      use Ada.Text_IO;
      use Ada.Strings.Fixed;
      --use Ada.Integer_Text_IO;
      use System;
      procedure Put_Address (A : Address) is
      begin
         Put (Address_Image (A));
      end;
      procedure Put_Column (S : String) is
      begin
         Put (Head (S, 30));
      end;
   begin
      Item.Dummy1 := False;
      Put_Column ("App'Address");
      Put_Address (Item'Address);
      New_Line;
      Put_Column ("App.Main_Window'Address");
      Put_Address (Item.Main_Window'Address);
      New_Line;
   end;


   procedure Init (Item : in out App) is
   begin
      GLFW3.Initialize;
      Item.Main_Window := GLFW3.Windows.Create_Window_Ada (1024, 1024, "Hello123##");
      GLFW3.Windows.Make_Context_Current (Item.Main_Window);
      GL.C.Initializations.Initialize (OpenGL_Loader_Test'Unrestricted_Access);

      GLFW3.Windows.Set_Window_User_Pointer (Item.Main_Window, Item'Address);
      GLFW3.Windows.Keys.Set_Key_Callback_Procedure (Item.Main_Window, Key_Callback'Access);

      Item.Main_Program := Shaders.Setup_Program;
      Item.Main_Transform_Location := GL.Programs.Uniforms.Get (Item.Main_Program, "transform");
      Item.Main_Time_Location := GL.Programs.Uniforms.Get (Item.Main_Program, "u_time");

      Cameras.Init (Item.Main_Camera);
      GL.Programs.Set_Current (Item.Main_Program);
      Debug_App (Item);
   end;

   procedure Update_Camera_GL (Item : App) is
   begin
      GL.Uniforms.Modify_Matrix_4f (Item.Main_Transform_Location, Item.Main_Camera.Result_Matrix'Address);
      GL.Uniforms.Modify_1f (Item.Main_Time_Location, 0.0);
   end;

   function Window_Closing (Item : in out App) return Boolean is
   begin
      Item.Dummy1 := False;
      if Window_Should_Close (Item.Main_Window) = 1 then
         return True;
      else
         return False;
      end if;
   end;

end Apps;
