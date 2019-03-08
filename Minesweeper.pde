import de.bezier.guido.*;
public final static int NUM_COLS = 20;
public final static int NUM_ROWS = 20;
private MSButton[][] buttons; //2d array of minesweeper buttons
private ArrayList <MSButton> bombs = new ArrayList<MSButton>();
int Bo = 20;
void setup ()
{
    size(400, 400);
    textAlign(CENTER,CENTER);
    
    // make the manager
    Interactive.make( this );
    buttons = new MSButton [NUM_ROWS][NUM_COLS];
    for (int r = 0;r < NUM_ROWS;r++)
    {
        for(int c = 0; c < buttons[r].length;c++)
        {
            buttons[r][c] = new MSButton(r,c);
        }
    }
    for(int d = 0; d < 50;d++)
    {
      setBombs();
    }
}
public void setBombs()
{
    int Rr = (int)(Math.random()*NUM_ROWS);
    int Rc = (int)(Math.random()*NUM_COLS);
    for (int i = 0;i < 50;i++)
    {
        if (!(bombs.contains(buttons[Rr][Rc])))
        {
          bombs.add(buttons[Rr][Rc]);
        }   
    }
}

public void draw ()
{
    background(0);
    if(isWon())
    {
        displayWinningMessage();
    }
}
public boolean isWon()
{
    
    for (int a = 0;a < NUM_ROWS;a++)
    {
        for(int n = 0;n <NUM_COLS;n++)
        {
            if (!bombs.contains(buttons[a][n]) && !buttons[a][n].isClicked())
            {
                return false;
            }
        }
    }
    return true;
}
public void displayLosingMessage()
{
    background(0);
}
public void displayWinningMessage()
{
    //your code here
}

public class MSButton
{
    private int r, c;
    private float x,y, width, height;
    private boolean clicked, marked;
    private String label;
    
    public MSButton (int rr,int cc)
    {
        width = 400/NUM_COLS;
        height = 400/NUM_ROWS;
        r = rr;
        c = cc; 
        x = c*width;
        y = r*height;
        label = "";
        marked = clicked = false;
        Interactive.add( this ); // register it with the manager
    }
    public boolean isMarked()
    {
        return marked;
    }
    public boolean isClicked()
    {
        return clicked;
    }  
    public void mousePressed() 
    {
        clicked = true;
        if(mouseButton == RIGHT)
        {
            if(isMarked())
            {
               marked = false; 
            }
            else
            {
              marked = true; 
              clicked = false;
            }
        }
        else if(bombs.contains(this))
        {
            displayLosingMessage();
        }
        else if(countBombs(r,c) > 0)
        {
            label = "" + countBombs(r,c);
        }
        else  
        {
            if (isValid(r, c - 1) && !buttons[r][c - 1].isClicked()) 
            {
                buttons[r][c - 1].mousePressed();
            }
            if (isValid(r, c + 1) && !buttons[r][c + 1].isClicked()) 
            {
                buttons[r][c + 1].mousePressed();
            }
            if (isValid(r - 1, c) && !buttons[r - 1][c].isClicked()) 
            {
                buttons[r - 1][c].mousePressed();
            }
            if (isValid(r + 1, c) && !buttons[r + 1][c].isClicked())
             {
                buttons[r + 1][c].mousePressed();
            }
            if (isValid(r + 1, c - 1) && !buttons[r + 1][c - 1].isClicked())
             {
                buttons[r + 1][c - 1].mousePressed();
            }
            if (isValid(r - 1, c + 1) && !buttons[r - 1][c + 1].isClicked()) 
            {
                buttons[r - 1][c + 1].mousePressed();
            }
            if (isValid(r - 1, c - 1) && !buttons[r - 1][c - 1].isClicked()) 
            {
                buttons[r - 1][c - 1].mousePressed();
            }
            if (isValid(r + 1, c + 1) && !buttons[r + 1][c + 1].isClicked()) {
                buttons[r + 1][c + 1].mousePressed();
        }
    }
}

    public void draw () 
    {    
        if (marked)
            fill(0);
        else if(clicked && bombs.contains(this)) 
            fill(255,0,0);
        else if(clicked)
            fill( 200 );
        else 
            fill( 100 );

        rect(x, y, width, height);
        fill(0);
        text(label,x+width/2,y+height/2);
    }
    public void setLabel(String newLabel)
    {
        label = newLabel;
    }
    public boolean isValid(int r, int c)
    {
       if (r < NUM_ROWS && c < NUM_COLS)
       {
        if (r > -1 && c > -1)
        {
            return true;
        }
       }
        return false;
    }
    public int countBombs(int row, int col)
    {
        //Thanks to natran951
        int numBombs = 0;
        for(int r = row-1; r <= row+1; r++) {
            for(int c = col-1; c <= col+1; c++) {
                if(isValid(r,c) && bombs.contains(buttons[r][c])) {
                    if(r==row&&c==col) {
                        continue;
                    }
                    numBombs++;
                }
            }
        }
        return numBombs;
    }
}



