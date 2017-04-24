using System;
using System.Collections.Generic;
using System.Text;
using MySql.Data.MySqlClient;

namespace CSharpMySql
{
    class Program
    {
        static string getString(string msg)
        {
            Console.Write(msg);
            return Console.ReadLine();
        }

        static void Main(string[] args)
        {
            String str = @"server=localhost;database=csharpsample;userid=root;
                password=241990;";
            MySqlConnection con = null;
            MySqlDataReader reader = null;
            try
            {
                con = new MySqlConnection(str);
                con.Open(); //open the connection

                //This is the mysql command that we will query into the db.
                //It uses Prepared statements and the Placeholder is @name.
                //Using prepared statements is faster and secure.
                //TO INSERT values into the database using prepares statements
                String cmdText = "INSERT INTO tableone VALUES(NULL,@name,@desc)";
                MySqlCommand cmd = new MySqlCommand(cmdText, con);
                cmd.Prepare();

                String name = string.Empty;
                String desc = string.Empty;

                name = getString("Enter name: ");
                desc = getString("Enter description: ");
                //we will bound a value to the placeholder
                cmd.Parameters.AddWithValue("@name", name);
                cmd.Parameters.AddWithValue("@desc", desc);
                cmd.ExecuteNonQuery(); //execute the mysql command
                Console.WriteLine("Inserting data to the database. Done!\n");

                Console.WriteLine("Retrieve the data from the database.");
                //To query data from the database using MySqlDataReader
                cmdText = "SELECT * FROM tableone";
                cmd.CommandText = cmdText;
                reader = cmd.ExecuteReader();

                Console.WriteLine("id|name|desc");
                while (reader.Read())
                {
                    Console.WriteLine(reader.GetString(0) + "|" + reader.GetString(1) + "|" + reader.GetString(2));
                }

            }
            catch (MySqlException err)
            {
                Console.WriteLine("Error: " + err.ToString());
            }
            finally
            {
                if (con != null)
                {
                    con.Close(); //close the connection
                }
                if (reader != null)
                {
                    reader.Close();
                }
            }

            Console.WriteLine("Press any key to exit.");
            Console.ReadLine();

        }
    }
}
