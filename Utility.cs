using System;
using System.Security.Cryptography;
using System.Text;

namespace ChatAppCS
{
    public class Utility
    {
        //To create a salt value to use during hashing
        public static String getRandomString(int size)
        {
            //Get random string
            var RNG = new Random();
            var randomStr = "";
            var flag = true;
            int choice;
            for (var len = 0; len <= size; len++)
            {
                choice = RNG.Next(0, 10);
                if (choice % 2 == 0)
                {
                    randomStr += RNG.Next(0, 100);
                }
                else
                {
                    char rngchar = Convert.ToChar(Convert.ToInt32(Math.Floor(26 * RNG.NextDouble() + 65)));
                    if (flag)
                    {
                        randomStr += rngchar.ToString().ToLower();
                    }
                    else
                    {
                        randomStr += rngchar.ToString().ToUpper();
                    }
                    flag = !flag;
                }
            }
            return randomStr;
        }

        public static string GetHash(String text, Byte[] salt)
        {
            //Converting text to Byte array

            Byte[] textBytes = Encoding.ASCII.GetBytes(text);

            //Combining salt and text
            Byte[] textAndSalt = new Byte[textBytes.Length + salt.Length];

            // Now with both the salt and text in one array, let us put them through
            // The SHA256 hash algorithm
            int i = 0;
            for (i = 0; i < textBytes.Length; i++)
            {
                textAndSalt[i] = textBytes[i];
            }
            for (int j = 0; j < salt.Length; j++, i++)
            {
                textAndSalt[i] = salt[j];
            }

            SHA256Managed sha = new SHA256Managed();
            Byte[] hashVal = sha.ComputeHash(textAndSalt);
            return Convert.ToBase64String(hashVal);
        }

    }
}