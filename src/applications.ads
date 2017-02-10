with GLFW3;
with GLFW3.Windows;

with GL.Uniforms;
with GL.C;


with Simple_Moving_Averages;
with Simple_Debug_Systems;
with Simple_Meshes;
with Simple_Cameras;
with Simple_Shaders;
with Simple_File_Drop_Storage;

package Applications is

   type Application is record
      Check_Sum : Integer := 555;
      Dummy1 : Boolean := False;
      Main_Window : GLFW3.Windows.Window;
      Main_Debug_Queue : Simple_Debug_Systems.Debug_Message_Queue;
      Grid_Stride : GL.C.GLfloat := 1.0;
      Grid_Mesh : Simple_Meshes.Mesh;
      Main_Mesh : Simple_Meshes.Mesh;
      Main_SMA : Simple_Moving_Averages.SMA;
      Main_Camera : Simple_Cameras.Camera;
      Main_Program : Simple_Shaders.Program;
      Main_Transform_Location : GL.Uniforms.Location;
      Main_Time_Location : GL.Uniforms.Location;
      Main_Dropped_Files_Queue : Simple_File_Drop_Storage.Simple_File_Queue;
   end record;



   procedure Initialize (Item : in out Application);
   function Window_Closing (Item : in out Application) return Boolean;
   procedure Swap_Buffers (Item : Application);
   procedure Poll_Events (Item : Application);
   procedure Quit (Item : in out Application);

   procedure Render_Stuff (Item : in out Application);

end Applications;
