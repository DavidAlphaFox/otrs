# --
# Copyright (C) 2001-2017 OTRS AG, http://otrs.com/
# --
# This software comes with ABSOLUTELY NO WARRANTY. For details, see
# the enclosed file COPYING for license information (AGPL). If you
# did not receive this file, see http://www.gnu.org/licenses/agpl.txt.
# --

package Kernel::Output::HTML::Layout::Popup;

use strict;
use warnings;

our $ObjectManagerDisabled = 1;

=head1 NAME

Kernel::Output::HTML::Layout::Popup - CSS/JavaScript

=head1 DESCRIPTION

All valid functions.

=head1 PUBLIC INTERFACE

=head2 PopupClose()

Generate a small HTML page which closes the pop-up window and
executes an action in the main window.

    # load specific URL in main window
    $LayoutObject->PopupClose(
        URL => "Action=AgentTicketZoom;TicketID=$TicketID"
    );

    or

    # reload main window
    $Self->{LayoutObject}->PopupClose(
        Reload => 1,
    );

=cut

sub PopupClose {
    my ( $Self, %Param ) = @_;

    if ( !$Param{URL} && !$Param{Reload} ) {
        $Kernel::OM->Get('Kernel::System::Log')->Log(
            Priority => 'error',
            Message  => 'Need URL or Reload!'
        );
        return;
    }

    # Generate the call Header() and Footer(
    my $Output = $Self->Header( Type => 'Small' );

    if ( $Param{URL} ) {

        # send data to JS
        $Self->AddJSData(
            Key   => 'PopupClose',
            Value => 'LoadParentURLAndClose',
        );
        $Self->AddJSData(
            Key   => 'PopupURL',
            Value => $Param{URL},
        );
    }
    else {

        # send data to JS
        $Self->AddJSData(
            Key   => 'PopupClose',
            Value => 'ReloadParentAndClose',
        );
    }

    $Output .= $Self->Footer( Type => 'Small' );
    return $Output;
}

1;

=head1 TERMS AND CONDITIONS

This software is part of the OTRS project (L<http://otrs.org/>).

This software comes with ABSOLUTELY NO WARRANTY. For details, see
the enclosed file COPYING for license information (AGPL). If you
did not receive this file, see L<http://www.gnu.org/licenses/agpl.txt>.

=cut
