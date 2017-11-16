#include <stdlib.h>
#include <stdio.h>

int countlines(char* filename){
  int ch = 'a';
  int lines =0;
  FILE *fp = fopen(filename,"r");
  while(!feof(fp)){
    ch = fgetc(fp);
    if(ch == '\n')
      {
	lines++;
      }
  }
  fclose(fp);
  return lines;
}
int** createMatrix(int lines,char* filename){
  int rows = lines;
  int columns = lines;
  int **matrix = (int **)calloc(rows,sizeof(int*));
  for(int i = 0; i < rows; i++){
    matrix[i] = (int *)calloc(columns,sizeof(int));
  } 
  //int ch =0;
  int first_id =0;
  int second_id =0;
  FILE *fp = fopen(filename,"r");
  while(!feof(fp)){
    fscanf(fp," %d %d",&first_id, &second_id);
    matrix[first_id][second_id]=1;
  }
  fclose(fp);
  return matrix;
}

int** fileToMatrix(){
  int lines = countlines("../preprocessing/nameToID.txt");
  int** matrix= createMatrix(lines,"../preprocessing/idfile.txt");
  return matrix;
}

int fileToRowCount(){
  return countlines("../preprocessing/nameToID.txt");
}

/*
  int main(int argc, char *argv[]){
  int lines = countlines("../preprocessing/nameToID.txt");
  int** matrix= createMatrix(lines,"../preprocessing/idfile.txt");
  printf("Number of Lines %d \n", lines);
  printf("value %d \n",matrix[4591][4583]);
  for (int i = 0; i < lines; i++) {
    free(matrix[i]);
  }
  free(matrix);
  return 0;
  }*/

