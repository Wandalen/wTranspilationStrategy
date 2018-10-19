( function _MainTop_s_( ) {

'use strict';

if( typeof module !== 'undefined' )
{

  require( './MainBase.s' );

}

//

let _ = wTools;
let Parent = null;
let Self = _.TranspilingStrategy;

_.assert( _.routineIs( _.TranspilingStrategy ) );

// --
// exec
// --

function Exec()
{
  let ts = new this.Self();
  return ts.exec();
}

//

function exec()
{
  let ts = this;

  ts.formAssociates();

  _.assert( _.instanceIs( ts ) );
  _.assert( arguments.length === 0 );

  let logger = ts.logger;
  let fileProvider = ts.fileProvider;
  let appArgs = _.appArgs();
  let ca = ts.commandsMake();

  return ca.proceedApplicationArguments({ appArgs : appArgs });
}

//

function commandsMake()
{
  let ts = this;
  let logger = ts.logger;
  let fileProvider = ts.fileProvider;
  let appArgs = _.appArgs();

  _.assert( _.instanceIs( ts ) );
  _.assert( arguments.length === 0 );

  let commands =
  {
    'help' :              { e : ts.commandHelp.bind( ts ),                h : 'Get help' },
    'strategies list' :   { e : ts.commandStrategiesList.bind( ts ),      h : 'List available strategies to transpile' },
    'transpile' :         { e : ts.commandTranspile.bind( ts ),           h : 'Transpile inPath file and store result at outPath' },
  }

  var ca = _.CommandsAggregator
  ({
    basePath : fileProvider.path.current(),
    commands : commands,
    commandPrefix : 'node ',
  })

  //ts._commandsConfigAdd( ca );

  ca.form();

  return ca;
}

//

function commandHelp( e )
{
  let ts = this;
  let fileProvider = ts.fileProvider;
  let logger = ts.logger;

  logger.log();
  logger.log( e.ca.vocabulary.helpForSubjectAsString( '' ) );
  logger.log();

  //logger.log( 'Use ' + logger.colorFormat( '"ts .init confPath:./conf" actionsPath:./actions', 'code' ) + ' to init the module' );
  logger.log( 'Use ' + logger.colorFormat( '"ts .help"', 'code' ) + ' to get help' );
  // logger.log( 'Use ' + logger.colorFormat( '"ts"', 'code' ) + '' );

  return ts;
}

//

function commandStrategiesList( e )
{
  let ts = this;
  let fileProvider = ts.fileProvider;
  let logger = ts.logger;

  debugger;
  logger.log( 'Available strategies' );
  logger.up();
  for( let s in ts.Strategies )
  {
    let strategy = ts.Strategies[ s ];
    logger.log( s, '-', strategy.name );
  }
  logger.down();

  return ts;
}

//

function commandTranspile( e )
{
  let ts = this;
  let fileProvider = ts.fileProvider;
  let logger = ts.logger;

  _.sureMapHasOnly( e.propertiesMap, commandTranspile.properties );
  _.sureBriefly( _.strIs( e.propertiesMap.inPath ), 'Expects path to file to transpile {-inPath-}' );
  _.sureBriefly( _.strIs( e.propertiesMap.outPath ), 'Expects path to file to save transpiled {-outPath-}' );

  if( ts.verbosity >= 3 )
  logger.log( ' # Transpiling', e.propertiesMap.outPath, '<-', e.propertiesMap.inPath );

  logger.up();

  let session = ts.Session
  ({
    ts : ts,
    inputPath : e.propertiesMap.inPath,
    outputPath : e.propertiesMap.outPath,
  });

  _.appArgsReadTo
  ({
    dst : ts,
    only : 0,
    propertiesMap : e.propertiesMap,
    namesMap :
    {
      'verbosity' : 'verbosity',
      'v' : 'verbosity',
    },
  });

  _.appArgsReadTo
  ({
    dst : session,
    only : 1,
    propertiesMap : e.propertiesMap,
    namesMap :
    {
      'inPath' : 'inputPath',
      'outPath' : 'outputPath',
      'strategies' : 'strategies',
    },
  });

  session.verbosity = ts.verbosity;

  session.form();

  return session.proceed()
  .doThen( ( err ) =>
  {
    if( err )
    _.errLogOnce( err );
    logger.down();
    session.finit();
  });
}

commandTranspile.properties =
{
  inPath : null,
  outPath : null,
  verbosity : null,
  v : null,
  strategies : null,
}

// --
// relations
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

let Statics =
{
  Exec : Exec,
}

let Forbids =
{
}

// --
// declare
// --

let Extend =
{

  // exec

  Exec : Exec,
  exec : exec,

  commandsMake : commandsMake,
  commandHelp : commandHelp,
  commandStrategiesList : commandStrategiesList,
  commandTranspile : commandTranspile,

  // relations

  Composes : Composes,
  Aggregates : Aggregates,
  Associates : Associates,
  Restricts : Restricts,
  Statics : Statics,
  Forbids : Forbids,

}

//

_.classExtend( Self, Extend );

//

if( typeof module !== 'undefined' && module !== null )
module[ 'exports' ] = wTools;
_global_[ Self.name ] = wTools[ Self.shortName ] = Self;

if( !module.parent )
Self.Exec();

})();
