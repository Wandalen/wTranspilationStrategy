( function _Text_s_()
{

'use strict';

//

const _ = _global_.wTools;
const Parent = _.trs.concatenator.Abstract;
const Self = wTsConcatenatorText;
function wTsConcatenatorText( o )
{
  return _.workpiece.construct( Self, this, arguments );
}

Self.shortName = 'Text';

// --
// routines
// --

function init()
{
  let self = Parent.prototype.init.apply( this, arguments );
  return self;
}

//

function _performAct( single )
{
  let self = this;
  let sys = self.sys;
  let result = '';
  let files = single.dataMap;
  let multiple = single.multiple;

  _.assert( _.mapIs( files ) );
  _.assert( arguments.length === 1 );
  _.assert( single instanceof _.trs.Single );

  /* */

  result = _.mapVals( files ).join( '\n' );

  return result;
}

// --
// relations
// --

let Composes =
{
  ext : _.define.own([ 'txt', '' ]),
}

let Associates =
{
  starter : null,
}

let Restricts =
{
}

// --
// prototype
// --

let Proto =
{

  init,

  _performAct,

  /* */

  Composes,
  Associates,
  Restricts,

}

//

_.classDeclare
({
  cls : Self,
  parent : Parent,
  extend : Proto,
});

//

if( typeof module !== 'undefined' )
module[ 'exports' ] = Self;

_.trs.concatenator[ Self.shortName ] = Self;

})();
