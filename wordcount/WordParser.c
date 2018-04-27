#include <stdio.h>
#include <stdlib.h>

typedef struct {
    char* str;
    struct _String *next;
} String;

int main (int argc, char** argv)
{
    FILE* input = fopen (argv[1], "r");
    if (input == NULL)
    {
        return EXIT_FAILURE;
    }

    String* word = NULL;
    String* word_ptr = word;
    int word_size = 1;

    while (!feof (input))
    {
        char c = fgetc (input);
        if ((c >= 65 && c <= 90) || (c >= 97 && c <= 122))
        {
            if (word == NULL)
            {
                word = malloc (sizeof (*word));
                word -> str = malloc (sizeof (*(word -> str)));
                word -> str [0] = c;
                word_ptr = word;
            }
            else if (word_ptr -> str == NULL)
            {
                word_ptr -> str = malloc (sizeof (*(word_ptr -> str)));
                word_ptr -> str [0] = c;
            }
            else
            {
                word_size++;
                word_ptr -> str = realloc (word_ptr -> str, sizeof (*(word_ptr -> str) * word_size));
                word_ptr -> str [word_size - 1] = c;
            }
        }
        else if (word_ptr != NULL && word_ptr -> str != NULL)
        {
            word_ptr -> next = malloc (sizeof (word_ptr -> next));
            word_ptr = (String *) word_ptr -> next;
            word_size = 1;
        }
    }

    for (String* ptr = word; ptr -> next != NULL; ptr = (String*) ptr -> next)
    {
        printf ("%s\n", ptr -> str);
    }
}
