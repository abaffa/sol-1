//---------------------------------------------------------------------------

#ifndef findH
#define findH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include <ExtCtrls.hpp>
//---------------------------------------------------------------------------
class Tffind : public TForm
{
__published:	// IDE-managed Components
        TLabeledEdit *LabeledEdit1;
        TButton *Button1;
        TButton *Button2;
private:	// User declarations
public:		// User declarations
        __fastcall Tffind(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE Tffind *ffind;
//---------------------------------------------------------------------------
#endif
