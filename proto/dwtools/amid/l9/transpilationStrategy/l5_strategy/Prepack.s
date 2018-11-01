( function _StrategyPrepack_s_() {

'use strict';

let Prepack = require( 'prepack' );

//

let _ = wTools;
let Parent = _.TranspilationStrategy.Strategies.Abstract;
let Self = function wTsStrategyPrepack( o )
{
  return _.instanceConstructor( Self, this, arguments );
}

Self.shortName = 'Prepack';

// --
//
// --

function _formAct()
{
  let self = this;
  let session = self.session;

  if( !self.settings )
  self.settings = {};
  let set = self.settings;

  return set;
}

//

function _executeAct()
{
  let self = this;
  let session = self.session;
  let result = null;

  debugger;
  result = Prepack.prepackSources( [{ fileContents : self.input.code }], self.settings );
  debugger;

  if( result.error )
  throw _.err( result.error );

  _.assert( _.strIs( result.code ) );
  _.mapExtend( self.output,result );

  return result;
}

// --
// relationships
// --

let Composes =
{
}

let Aggregates =
{
}

let Associates =
{
}

let Restricts =
{
}

// --
// prototype
// --

let Proto =
{

  _formAct : _formAct,
  _executeAct : _executeAct,


  /* */

  /* constructor * : * Self, */
  Composes : Composes,
  Aggregates : Aggregates,
  Associates : Associates,
  Restricts : Restricts,

}

//

_.classDeclare
({
  cls : Self,
  parent : Parent,
  extend : Proto,
});

//

if( typeof module !== 'undefined' && module !== null )
module[ 'exports' ] = Self;

_.TranspilationStrategy.Strategies[ Self.shortName ] = Self;

})();